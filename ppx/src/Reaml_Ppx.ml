open Parsetree

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
          ( Nonrecursive
          , [ { pvb_pat
              ; pvb_expr =
                  { pexp_desc =
                      Pexp_apply (({ pexp_desc = Pexp_ident { txt = _ } } as ident), args)
                  }
              ; pvb_loc
              }
            ]
          , expr )
    ; pexp_attributes = [ ({ txt = "reaml" }, PStr []) ]
    }
  | { pexp_desc =
        Pexp_let
          ( Nonrecursive
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
    let args = args @ [ "", [%expr Reaml.undefined] ] in
    Ast_helper.Exp.let_
      Nonrecursive
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

let main _argv =
  { Ast_mapper.default_mapper with
    expr =
      (fun mapper expr ->
        check
          (match expr with
          | { pexp_desc = Pexp_fun ("", None, args, expr)
            ; pexp_attributes =
                [ ( { txt = "reaml.component" }
                  , PStr
                      [ { pstr_desc =
                            Pstr_eval
                              ( ({ pexp_desc = Pexp_constant (Const_string (_, None)) }
                                as name)
                              , _ )
                        }
                      ] )
                ]
            ; pexp_loc
            } ->
            let inner =
              Ast_helper.Exp.fun_ ~loc:pexp_loc "" None args (rewrite_let expr)
            in
            [%expr Reaml.component [%e name] [%e inner]]
          | { pexp_desc = Pexp_fun ("", None, args, expr)
            ; pexp_attributes = [ ({ txt = "reaml.hook" }, PStr []) ]
            } ->
            Ast_helper.Exp.fun_
              ""
              None
              args
              [%expr fun (_ : Reaml.undefined) -> [%e rewrite_let expr]]
          | _ -> Ast_mapper.default_mapper.expr mapper expr))
  }

let () = Ast_mapper.run_main main
