open Migrate_parsetree
open Ast_402
open Ast_402.Parsetree

(* Check that there are no reaml attributes left after the code is processed. *)
let check expr =
  let mapper =
    { Ast_mapper.default_mapper with
      expr =
        (fun mapper expr ->
          match expr with
          | { pexp_attributes =
                [ ({ txt = ("reaml.component" | "reaml.hook" | "reaml") as txt }, _) ]
            ; pexp_loc
            } ->
            raise
              (Location.Error
                 (Location.error
                    ~loc:pexp_loc
                    ("[@" ^ txt ^ "] occurs in an inappropriate place")))
          | _ -> Ast_mapper.default_mapper.expr mapper expr)
    }
  in
  Ast_mapper.default_mapper.expr mapper expr

let rec rewrite_let = function
  | { pexp_desc =
        Pexp_let
          ( recursive
          , [ { pvb_pat
              ; pvb_expr =
                  { pexp_desc =
                      Pexp_apply (({ pexp_desc = Pexp_ident { txt = _ } } as ident), args)
                  }
              ; pvb_loc
              ; pvb_attributes = [ ({ txt = "reaml" }, PStr []) ]
              }
            ]
          , expr )
    }
  | { pexp_desc =
        Pexp_let
          ( recursive
          , [ { pvb_pat =
                  { ppat_attributes = [ ({ txt = "reaml" }, PStr []) ] } as pvb_pat
              ; pvb_expr =
                  { pexp_desc =
                      Pexp_apply (({ pexp_desc = Pexp_ident { txt = _ } } as ident), args)
                  }
              ; pvb_loc
              }
            ]
          , expr )
    } ->
    let args =
      args
      @ [ ( ""
          , { pexp_desc =
                Pexp_ident { txt = Ldot (Lident "Reaml", "undefined"); loc = pvb_loc }
            ; pexp_loc = pvb_loc
            ; pexp_attributes = []
            } )
        ]
    in
    Ast_helper.Exp.let_
      recursive
      [ { pvb_pat = { pvb_pat with ppat_attributes = [] }
        ; pvb_expr = Ast_helper.Exp.apply ident args
        ; pvb_attributes = []
        ; pvb_loc
        }
      ]
      (rewrite_let expr)
  | { pexp_desc = Pexp_let (recursive, bindings, expr) } as e ->
    { e with pexp_desc = Pexp_let (recursive, bindings, rewrite_let expr) }
  | otherwise -> otherwise

let mapper _ _ =
  { Ast_mapper.default_mapper with
    expr =
      (fun mapper expr ->
        check
          (match expr with
          | { pexp_desc = Pexp_fun ("", None, args, expr)
            ; pexp_attributes =
                [ ( { txt = ("reaml.component" | "reaml.component.recursive") as txt }
                  , PStr
                      [ { pstr_desc =
                            Pstr_eval
                              ( ({ pexp_desc = Pexp_constant (Const_string (_, None)) } as
                                name)
                              , _ )
                        }
                      ] )
                ]
            ; pexp_loc
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
              | "reaml.component" ->
                ( Ast_helper.Exp.fun_ ~loc:pexp_loc "" None args (rewrite_let expr)
                , "component" )
              | "reaml.component.recursive" ->
                (match expr with
                | { pexp_desc = Pexp_fun ("", None, args', expr) } ->
                  ( Ast_helper.Exp.fun_
                      ~loc:pexp_loc
                      ""
                      None
                      args
                      (Ast_helper.Exp.fun_ ~loc:pexp_loc "" None args' (rewrite_let expr))
                  , "recursiveComponent" )
                | _ ->
                  raise
                    (Location.Error
                       (Location.error
                          ~loc:pexp_loc
                          "a recursive component should take exactly 2 arguments")))
              | _ ->
                raise (Location.Error (Location.error ~loc:pexp_loc "this can't happen"))
            in
            Ast_helper.Exp.apply
              { pexp_desc = Pexp_ident { txt = Ldot (Lident "Reaml", fn); loc = pexp_loc }
              ; pexp_loc
              ; pexp_attributes = []
              }
              [ "", name; "", inner ]
          | { pexp_desc = Pexp_fun ("", None, args, expr)
            ; pexp_attributes = [ ({ txt = "reaml.hook" }, PStr []) ]
            ; pexp_loc
            } ->
            Ast_helper.Exp.fun_
              ""
              None
              args
              (Ast_helper.Exp.fun_
                 ~loc:pexp_loc
                 ""
                 None
                 { ppat_loc = pexp_loc
                 ; ppat_attributes = []
                 ; ppat_desc =
                     Ppat_constraint
                       ( { ppat_loc = pexp_loc
                         ; ppat_attributes = []
                         ; ppat_desc = Ppat_any
                         }
                       , { ptyp_loc = pexp_loc
                         ; ptyp_attributes = []
                         ; ptyp_desc =
                             Ptyp_constr
                               ( { txt = Ldot (Lident "Reaml", "undefined")
                                 ; loc = pexp_loc
                                 }
                               , [] )
                         } )
                 }
                 (rewrite_let expr))
          | _ -> Ast_mapper.default_mapper.expr mapper expr))
  ; structure =
      (fun mapper structures ->
        let f structure return =
          match structure with
          | { pstr_desc =
                Pstr_primitive
                  { pval_attributes = [ ({ txt = "reaml.component" }, PStr []) ]
                  ; pval_name = { txt; loc }
                  }
            } as s ->
            let maker =
              { pstr_desc =
                  Pstr_value
                    ( Nonrecursive
                    , [ { pvb_pat =
                            { ppat_desc = Ppat_var { txt; loc }
                            ; ppat_attributes = []
                            ; ppat_loc = loc
                            }
                        ; pvb_expr =
                            { pexp_desc =
                                Pexp_fun
                                  ( ""
                                  , None
                                  , { ppat_desc = Ppat_var { txt = "props"; loc }
                                    ; ppat_attributes = []
                                    ; ppat_loc = loc
                                    }
                                  , { pexp_desc =
                                        Pexp_apply
                                          ( { pexp_desc =
                                                Pexp_ident
                                                  { txt =
                                                      Ldot
                                                        ( Ldot (Lident "Reaml", "Internal")
                                                        , "createComponentElement" )
                                                  ; loc
                                                  }
                                            ; pexp_loc = loc
                                            ; pexp_attributes = []
                                            }
                                          , [ ( ""
                                              , { pexp_desc =
                                                    Pexp_ident { txt = Lident txt; loc }
                                                ; pexp_loc = loc
                                                ; pexp_attributes = []
                                                } )
                                            ; ( ""
                                              , { pexp_desc =
                                                    Pexp_ident
                                                      { txt = Lident "props"; loc }
                                                ; pexp_loc = loc
                                                ; pexp_attributes = []
                                                } )
                                            ] )
                                    ; pexp_loc = loc
                                    ; pexp_attributes = []
                                    } )
                            ; pexp_loc = loc
                            ; pexp_attributes = []
                            }
                        ; pvb_loc = loc
                        ; pvb_attributes = []
                        }
                      ] )
              ; pstr_loc = loc
              }
            in
            s :: maker :: return
          | s -> s :: return
        in
        Ast_mapper.default_mapper.structure mapper (List.fold_right f structures []))
  }

let () =
  Migrate_parsetree.Driver.register
    ~name:"reaml"
    ~args:[]
    Migrate_parsetree.Versions.ocaml_402
    mapper
