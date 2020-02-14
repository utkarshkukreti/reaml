module R = Reaml

module Clicks = struct
  type action = Clicked of int * int

  let reducer state = function
    | Clicked (x, y) -> (x, y) :: state

  let make =
   fun [@reaml.component "Clicks"] () ->
    let[@reaml] state, dispatch = R.useReducer reducer [] in
    R.div
      [
        R.style "height" "400px";
        R.style "padding" "1rem";
        R.style "background" "#fefcbf";
        R.style "border" "2px dashed #F6E05E";
        R.style "borderRadius" "4px";
        R.style "overflow" "scroll";
        R.style "marginBottom" "2rem";
        R.style "userSelect" "none";
        R.onClick (fun event ->
            dispatch R.Event.Mouse.(Clicked (clientX event, clientY event)));
      ]
      [
        R.h1 [] [ R.string "Click Anywhere!" ];
        R.div
          []
          [
            R.ul
              []
              (state |. Belt.List.map (fun (x, y) -> R.li [] [ R.string {j|$x × $y|j} ]));
          ];
      ]
end

let main = R.div [] [ Clicks.make () ]
let () = main |> R.renderTo "main"
