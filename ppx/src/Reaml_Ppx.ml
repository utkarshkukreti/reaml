open Migrate_parsetree
open Ast_410
open Ast_410.Parsetree
open Ast_helper

(* Check that there are no reaml attributes left after the code is processed. *)
let checker =
  let throw txt loc =
    raise
      (Location.Error
         (Location.error ~loc ("[@" ^ txt ^ "] occurs in an inappropriate place")))
  in
  let isReaml string =
    string = "reaml" || Base.String.is_prefix string ~prefix:"reaml."
  in
  let mapper =
    {
      Ast_mapper.default_mapper with
      expr =
        (fun mapper expr ->
          match expr with
          | { pexp_attributes = [ { attr_name = { txt } } ]; pexp_loc } when isReaml txt
            -> throw txt pexp_loc
          | _ -> Ast_mapper.default_mapper.expr mapper expr);
      value_binding =
        (fun mapper value_binding ->
          match value_binding with
          | { pvb_attributes = [ { attr_name = { txt } } ]; pvb_loc } when isReaml txt ->
            throw txt pvb_loc
          | _ -> Ast_mapper.default_mapper.value_binding mapper value_binding);
    }
  in
  mapper

let check_expr expr =
  Ast_mapper.default_mapper.expr checker expr |> checker.expr Ast_mapper.default_mapper

let check_value_binding value_binding =
  Ast_mapper.default_mapper.value_binding checker value_binding
  |> checker.value_binding Ast_mapper.default_mapper

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
                pvb_attributes = [ { attr_name = { txt = "reaml" } } ];
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
                  { ppat_attributes = [ { attr_name = { txt = "reaml" } } ] } as pvb_pat;
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
    let args = args @ [ Nolabel, [%expr Reaml.undefined] ] in
    Exp.let_ recursive
      [
        Vb.mk ~loc:pvb_loc ~attrs:[]
          { pvb_pat with ppat_attributes = [] }
          (Exp.apply ident args);
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
    expr = (fun mapper expr -> Ast_mapper.default_mapper.expr mapper (check_expr expr));
    value_binding =
      (fun mapper value_binding ->
        check_value_binding
          (match value_binding with
          | {
           pvb_pat;
           pvb_expr = { pexp_desc = Pexp_fun (Nolabel, None, args, expr); pexp_loc };
           pvb_loc;
           pvb_attributes =
             [
               {
                 attr_name =
                   {
                     txt =
                       ( "reaml.component"
                       | "reaml.component.memo"
                       | "reaml.component.recursive"
                       | "reaml.component.recursive.memo" ) as txt;
                   };
                 attr_payload;
                 attr_loc;
               };
             ];
          } ->
            let name =
              match attr_payload with
              | PStr
                  [
                    {
                      pstr_desc =
                        Pstr_eval
                          ( ({ pexp_desc = Pexp_constant (Pconst_string (_, None)) } as
                            name),
                            _ );
                    };
                  ] -> name
              | _ ->
                raise
                  (Location.Error
                     (Location.error ~loc:attr_loc
                        ("`@"
                        ^ txt
                        ^ "` must be followed with a string - the component's name")))
            in
            let () =
              match args with
              | { ppat_desc = Ppat_construct ({ txt = Lident "()" }, None) }
              | { ppat_desc = Ppat_record _ } -> ()
              | { ppat_loc } ->
                raise
                  (Location.Error
                     (Location.error ~loc:ppat_loc
                        "the argument to a component must either be unit (`()`) or a \
                         record pattern (`{foo = foo; bar = _}`)"))
            in
            let () =
              match args with
              | { ppat_desc = Ppat_record (args, _) } ->
                args
                |> List.iter (function
                     | { Asttypes.txt = Longident.Lident "key"; loc }, _ ->
                       raise
                         (Location.Error
                            (Location.error ~loc
                               "the `key` prop cannot be accessed inside a component"))
                     | _ -> ())
              | _ -> ()
            in
            let inner, fn =
              match txt with
              | "reaml.component" | "reaml.component.memo" ->
                ( Exp.fun_ ~loc:pexp_loc Nolabel None args (rewrite_let expr),
                  [%expr Reaml.component] )
              | "reaml.component.recursive" | "reaml.component.recursive.memo" ->
                (match expr with
                | {
                 pexp_desc = Pexp_fun (Nolabel, None, args', expr);
                 pexp_loc = pexp_loc_2;
                } ->
                  ( Exp.fun_ ~loc:pexp_loc Nolabel None args
                      (Exp.fun_ ~loc:pexp_loc_2 Nolabel None args' (rewrite_let expr)),
                    [%expr Reaml.recursiveComponent] )
                | _ ->
                  raise
                    (Location.Error
                       (Location.error ~loc:pexp_loc
                          "a recursive component should take exactly 2 arguments")))
              | _ ->
                raise (Location.Error (Location.error ~loc:pexp_loc "this can't happen"))
            in
            let pvb_expr =
              if Base.String.is_substring txt ~substring:".memo"
              then [%expr [%e fn] ~memo:true ~name:[%e name] [%e inner]]
              else [%expr [%e fn] ~name:[%e name] [%e inner]]
            in
            Vb.mk ~loc:pvb_loc pvb_pat pvb_expr
          | {
           pvb_expr = { pexp_desc = Pexp_fun (Nolabel, None, args, expr); pexp_loc };
           pvb_attributes = [ { attr_name = { txt = "reaml.hook" } } ];
           pvb_pat;
           pvb_loc;
          } ->
            let pvb_expr =
              Exp.fun_ Nolabel None args
                [%expr fun (_ : Reaml.undefined) -> [%e rewrite_let expr]]
            in
            Vb.mk ~loc:pvb_loc pvb_pat pvb_expr
          | _ -> Ast_mapper.default_mapper.value_binding mapper value_binding));
    structure =
      (let isReamlComponent = function
         | { attr_name = { txt = "reaml.component" } } -> true
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
               Str.value ~loc Nonrecursive
                 [
                   Vb.mk ~loc ~attrs:[]
                     (Pat.var ~loc { txt; loc })
                     [%expr
                       fun props ->
                         Reaml.createComponentElement
                           [%e Exp.ident ~loc { txt = Lident txt; loc }]
                           props];
                 ]
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
  Migrate_parsetree.Driver.register ~name:"reaml" ~args:[]
    Migrate_parsetree.Versions.ocaml_410 mapper
