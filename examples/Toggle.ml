module R = Reaml

module Counter = struct
  type props = { initial : int }

  let make =
   fun [@reaml.component "Counter"] { initial } ->
    let[@reaml] count, setCount = R.useState initial in
    R.button [ R.onClick (fun _ -> setCount (count + 1)) ] [ R.int count ]
end

module Toggle = struct
  type props = { f : unit -> R.vnode }

  let make =
   fun [@reaml.component "Toggle"] { f } ->
    let[@reaml] show, setShow = R.useState true in
    R.div
      []
      [
        R.button [ R.onClick (fun _ -> setShow (not show)) ] [ R.string "Toggle" ];
        R.string " ";
        (if show then f () else R.null);
      ]
end

let main =
  R.div
    []
    [
      Toggle.make { f = (fun () -> Counter.make { initial = -3 }) };
      Toggle.make { f = (fun () -> Counter.make { initial = 0 }) };
      Toggle.make { f = (fun () -> Counter.make { initial = 3 }) };
    ]

let () = main |> R.renderTo "main"
