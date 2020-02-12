module R = Reaml

module Tree = struct
  type t =
    | Many of string * t list
    | Leaf of string

  type props = { t : t }

  let make =
   fun [@reaml.component.recursive "Tree"] { t } make ->
    let[@reaml] collapsed, setCollapsed = R.useState false in
    match t with
    | Many (value, many) ->
      R.div
        []
        [
          R.div [ R.onClick (fun _ -> setCollapsed (not collapsed)) ] [ R.string value ];
          (if collapsed
          then R.null
          else R.ul [] (many |. Belt.List.map (fun m -> R.li [] [ make { t = m } ])));
        ]
    | Leaf leaf -> R.string leaf
end

let main =
  Tree.make
    {
      t =
        Tree.Many
          ( "h",
            [
              Many
                ( "i",
                  [
                    Leaf "hello";
                    Leaf "world";
                    Many ("j", [ Leaf "foo"; Leaf "bar" ]);
                    Leaf "baz";
                  ] );
            ] );
    }

let () = main |> R.renderTo "main"
