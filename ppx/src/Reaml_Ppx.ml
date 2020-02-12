open Migrate_parsetree
open Ast_406
open Ast_406.Parsetree
open Ast_helper

(* Check that there are no reaml attributes left after the code is processed. *)
let check expr =
  let throw txt loc =
    raise
      (Location.Error
         (Location.error ~loc ("[@" ^ txt ^ "] occurs in an inappropriate place")))
  in
  let mapper =
    {
      Ast_mapper.default_mapper with
      expr =
        (fun mapper expr ->
          match expr with
          | {
           pexp_attributes =
             [ ({ txt = ("reaml.component" | "reaml.hook" | "reaml") as txt }, _) ];
           pexp_loc;
          } -> throw txt pexp_loc
          | _ -> Ast_mapper.default_mapper.expr mapper expr);
      value_binding =
        (fun mapper value_binding ->
          match value_binding with
          | {
           pvb_attributes =
             [ ({ txt = ("reaml.component" | "reaml.hook" | "reaml") as txt }, _) ];
           pvb_loc;
          } -> throw txt pvb_loc
          | _ -> Ast_mapper.default_mapper.value_binding mapper value_binding);
    }
  in
  Ast_mapper.default_mapper.expr mapper expr

let rec rewrite_let = function
  | {
      pexp_desc =
        Pexp_let
          ( recursive,
            [
              {
                pvb_pat;
                pvb_expr =
                  {
                    pexp_desc =
                      Pexp_apply (({ pexp_desc = Pexp_ident { txt = _ } } as ident), args);
                  };
                pvb_loc;
                pvb_attributes = [ ({ txt = "reaml" }, PStr []) ];
              };
            ],
            expr );
    }
  | {
      pexp_desc =
        Pexp_let
          ( recursive,
            [
              {
                pvb_pat =
                  { ppat_attributes = [ ({ txt = "reaml" }, PStr []) ] } as pvb_pat;
                pvb_expr =
                  {
                    pexp_desc =
                      Pexp_apply (({ pexp_desc = Pexp_ident { txt = _ } } as ident), args);
                  };
                pvb_loc;
              };
            ],
            expr );
    } ->
    let args =
      args
      @ [
          ( Nolabel,
            Exp.ident { txt = Ldot (Lident "Reaml", "undefined"); loc = Location.none } );
        ]
    in
    Exp.let_
      recursive
      [
        {
          pvb_pat = { pvb_pat with ppat_attributes = [] };
          pvb_expr = Exp.apply ident args;
          pvb_attributes = [];
          pvb_loc;
        };
      ]
      (rewrite_let expr)
  | { pexp_desc = Pexp_let (recursive, bindings, expr); pexp_loc } ->
    Exp.let_ ~loc:pexp_loc recursive bindings (rewrite_let expr)
  | { pexp_desc = Pexp_sequence (expr, expr2); pexp_loc } ->
    Exp.sequence ~loc:pexp_loc expr (rewrite_let expr2)
  | otherwise -> otherwise

let mapper _ _ =
  {
    Ast_mapper.default_mapper with
    expr =
      (fun mapper expr ->
        check
          (match expr with
          | {
           pexp_desc = Pexp_fun (Nolabel, None, args, expr);
           pexp_attributes =
             [
               ( {
                   txt =
                     ( "reaml.component"
                     | "reaml.component.memo"
                     | "reaml.component.recursive"
                     | "reaml.component.recursive.memo" ) as txt;
                 },
                 PStr
                   [
                     {
                       pstr_desc =
                         Pstr_eval
                           ( ({ pexp_desc = Pexp_constant (Pconst_string (_, None)) } as
                             name),
                             _ );
                     };
                   ] );
             ];
           pexp_loc;
          } ->
            let () =
              match args with
              | { ppat_desc = Ppat_construct ({ txt = Lident "()" }, None) }
              | { ppat_desc = Ppat_record _ } -> ()
              | { ppat_loc } ->
                raise
                  (Location.Error
                     (Location.error
                        ~loc:ppat_loc
                        "the argument to a component must either be unit (`()`) or a \
                         record pattern (`{foo = foo; bar = _}`)"))
            in
            let inner, fn =
              match txt with
              | "reaml.component" | "reaml.component.memo" ->
                Exp.fun_ ~loc:pexp_loc Nolabel None args (rewrite_let expr), "component"
              | "reaml.component.recursive" | "reaml.component.recursive.memo" ->
                (match expr with
                | {
                 pexp_desc = Pexp_fun (Nolabel, None, args', expr);
                 pexp_loc = pexp_loc_2;
                } ->
                  ( Exp.fun_
                      ~loc:pexp_loc
                      Nolabel
                      None
                      args
                      (Exp.fun_ ~loc:pexp_loc_2 Nolabel None args' (rewrite_let expr)),
                    "recursiveComponent" )
                | _ ->
                  raise
                    (Location.Error
                       (Location.error
                          ~loc:pexp_loc
                          "a recursive component should take exactly 2 arguments")))
              | _ ->
                raise (Location.Error (Location.error ~loc:pexp_loc "this can't happen"))
            in
            Exp.apply
              (Exp.ident { txt = Ldot (Lident "Reaml", fn); loc = Location.none })
              (List.append
                 (if Base.String.is_substring txt ~substring:".memo"
                 then
                   [
                     ( Asttypes.Labelled "memo",
                       Exp.construct { txt = Lident "true"; loc = Location.none } None );
                   ]
                 else [])
                 [ Nolabel, name; Nolabel, inner ])
          | {
           pexp_desc = Pexp_fun (Nolabel, None, args, expr);
           pexp_attributes = [ ({ txt = "reaml.hook" }, PStr []) ];
           pexp_loc;
          } ->
            Exp.fun_
              Nolabel
              None
              args
              (Exp.fun_
                 ~loc:pexp_loc
                 Nolabel
                 None
                 (Pat.constraint_
                    (Pat.any ())
                    (Typ.constr
                       { txt = Ldot (Lident "Reaml", "undefined"); loc = Location.none }
                       []))
                 (rewrite_let expr))
          | _ -> Ast_mapper.default_mapper.expr mapper expr));
    structure =
      (let isReamlComponent (a : Parsetree.attribute) =
         match a with
         | { txt = "reaml.component" }, PStr [] -> true
         | _ -> false
       in
       fun mapper structures ->
         let f structure return =
           match structure with
           | {
               pstr_desc =
                 Pstr_primitive
                   ({ pval_attributes; pval_name = { txt; loc } } as pstr_primitive);
             } as s
             when List.exists isReamlComponent pval_attributes ->
             let maker =
               {
                 pstr_desc =
                   Pstr_value
                     ( Nonrecursive,
                       [
                         {
                           pvb_pat =
                             {
                               ppat_desc = Ppat_var { txt; loc };
                               ppat_attributes = [];
                               ppat_loc = loc;
                             };
                           pvb_expr =
                             Exp.fun_
                               ~loc
                               Nolabel
                               None
                               (Pat.var ~loc { txt = "props"; loc })
                               (Exp.apply
                                  ~loc
                                  (Exp.ident
                                     ~loc
                                     {
                                       txt =
                                         Ldot (Lident "Reaml", "createComponentElement");
                                       loc;
                                     })
                                  [
                                    Nolabel, Exp.ident ~loc { txt = Lident txt; loc };
                                    Nolabel, Exp.ident ~loc { txt = Lident "props"; loc };
                                  ]);
                           pvb_loc = loc;
                           pvb_attributes = [];
                         };
                       ] );
                 pstr_loc = loc;
               }
             in
             let s =
               {
                 s with
                 pstr_desc =
                   Pstr_primitive
                     {
                       pstr_primitive with
                       pval_attributes =
                         List.filter (fun a -> not (isReamlComponent a)) pval_attributes;
                     };
               }
             in
             s :: maker :: return
           | s -> s :: return
         in
         Ast_mapper.default_mapper.structure mapper (List.fold_right f structures []));
  }

let () =
  Migrate_parsetree.Driver.register
    ~name:"reaml"
    ~args:[]
    Migrate_parsetree.Versions.ocaml_406
    mapper
