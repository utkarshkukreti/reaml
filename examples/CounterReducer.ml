module R = Reaml

module Counter = struct
  type props = { initial : int }

  type action =
    | Increment
    | Decrement

  let reducer state = function
    | Increment -> state + 1
    | Decrement -> state - 1

  let make =
   fun [@reaml.component "Counter"] { initial } ->
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

let main =
  R.div
    []
    [ Counter.make { initial = -3 }
    ; Counter.make { initial = 0 }
    ; Counter.make { initial = 3 }
    ]

let () = main |> R.renderTo "main"
