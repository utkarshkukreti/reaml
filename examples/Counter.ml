module R = Reaml

module Counter = struct
  let make =
   fun [@reaml.component "Counter"] initial ->
    let[@reaml] count, setCount = R.useState initial in
    R.div
      []
      [ R.button [ R.onClick (fun _ -> setCount (count - 1)) ] [ R.string "-" ]
      ; R.string " "
      ; R.int count
      ; R.string " "
      ; R.button [ R.onClick (fun _ -> setCount (count + 1)) ] [ R.string "+" ]
      ]
end

let main = R.div [] [ Counter.make (-3); Counter.make 0; Counter.make 3 ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
