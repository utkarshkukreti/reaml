module R = Reaml

module Counter = struct
  let make =
   fun [@reaml.component "Counter"] initial ->
    let[@reaml] count, setCount = R.useState initial in
    R.button [ R.onClick (fun _ -> setCount (count + 1)) ] [ R.int count ]
end

module Toggle = struct
  let make =
   fun [@reaml.component "Toggle"] f ->
    let[@reaml] show, setShow = R.useState true in
    R.div
      []
      [ R.button [ R.onClick (fun _ -> setShow (not show)) ] [ R.string "Toggle" ]
      ; R.string " "
      ; (if show then f () else R.null)
      ]
end

let main =
  R.div
    []
    [ Toggle.make (fun () -> Counter.make (-3))
    ; Toggle.make (fun () -> Counter.make 0)
    ; Toggle.make (fun () -> Counter.make 3)
    ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
