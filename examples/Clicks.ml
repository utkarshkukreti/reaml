module R = Reaml

module Clicks = struct
  type action = Clicked of int * int

  let reducer state = function
    | Clicked (x, y) -> (x, y) :: state

  let make =
   fun [@reaml.component "Clicks"] () ->
    let[@reaml] state, dispatch = R.useReducer reducer [] in
    R.div
      [ R.style "width" "calc(100vw - 2rem)"
      ; R.style "height" "calc(100vh - 7rem)"
      ; R.style "padding" "1rem"
      ; R.style "background" "#ffc"
      ; R.style "overflow" "scroll"
      ; R.style "margin-bottom" "2rem"
      ; R.onClick (fun event ->
            dispatch R.Event.Mouse.(Clicked (clientX event, clientY event)))
      ]
      [ R.h1 [] [ R.string "Click Anywhere!" ]
      ; R.div
          []
          [ R.ul
              []
              (state |. Belt.List.map (fun (x, y) -> R.li [] [ R.string {j|$x * $y|j} ]))
          ]
      ]
end

let main = R.div [] [ Clicks.make () ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
