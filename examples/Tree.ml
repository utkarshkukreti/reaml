module R = Reaml

module Tree = struct
  type t =
    | Many of string * t list
    | Leaf of string

  let make =
   fun [@reaml.component.recursive "Tree"] make t ->
    let[@reaml] collapsed, setCollapsed = R.useState false R.undefined in
    match t with
    | Many (value, many) ->
      R.div
        []
        [ R.div [ R.onClick (fun _ -> setCollapsed (not collapsed)) ] [ R.string value ]
        ; (if collapsed
          then R.null
          else R.ul [] (many |. Belt.List.map (fun m -> R.li [] [ make m ])))
        ]
    | Leaf leaf -> R.string leaf
end

let main =
  Tree.make
    (Tree.Many
       ( "h"
       , [ Many
             ( "i"
             , [ Leaf "hello"
               ; Leaf "world"
               ; Many ("j", [ Leaf "foo"; Leaf "bar" ])
               ; Leaf "baz"
               ] )
         ] ))

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
