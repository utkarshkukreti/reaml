module R = Reaml

module Counter = struct
  type action =
    | Increment
    | Decrement

  let reducer state = function
    | Increment -> state + 1
    | Decrement -> state - 1

  let make =
   fun [@reaml.component "Counter"] initial ->
    let[@reaml] count, dispatch = R.useReducer reducer initial in
    R.div
      []
      [ R.button [ R.onClick (fun _ -> dispatch Decrement) ] [ R.string "-" ]
      ; R.string " "
      ; R.int count
      ; R.string " "
      ; R.button [ R.onClick (fun _ -> dispatch Increment) ] [ R.string "+" ]
      ]
end

let main = R.div [] [ Counter.make (-3); Counter.make 0; Counter.make 3 ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
