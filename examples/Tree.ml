module R = Reaml

module Tree = struct
  type t =
    | Node of string * t list
    | Leaf of string

  type props = { value : t }

  let make =
   fun [@reaml.component.recursive "Tree"] { value } make ->
    let[@reaml] collapsed, setCollapsed = R.useState false in
    match value with
    | Node (value, many) ->
      R.div
        []
        [
          R.div [ R.onClick (fun _ -> setCollapsed (not collapsed)) ] [ R.string value ];
          (if collapsed
          then R.null
          else R.ul [] (many |. Belt.List.map (fun value -> R.li [] [ make { value } ])));
        ]
    | Leaf leaf -> R.string leaf
end

let main =
  Tree.make
    {
      value =
        Tree.Node
          ( "h",
            [
              Node
                ( "i",
                  [
                    Leaf "hello";
                    Leaf "world";
                    Node ("j", [ Leaf "foo"; Leaf "bar" ]);
                    Leaf "baz";
                  ] );
            ] );
    }

let () = main |> R.renderTo "main"
