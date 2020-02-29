module R = Reaml

module Counter = struct
  type props = { initial : int }

  let[@reaml.component "Counter"] make { initial } =
    let[@reaml] count, setCount = R.useState initial in
    R.div []
      [
        R.button [ R.onClick (fun _ -> setCount (count - 1)) ] [ R.string "-" ];
        R.string " ";
        R.int count;
        R.string " ";
        R.button [ R.onClick (fun _ -> setCount (count + 1)) ] [ R.string "+" ];
      ]
end

let main =
  R.div []
    [
      Counter.make { initial = -3 };
      Counter.make { initial = 0 };
      Counter.make { initial = 3 };
    ]

let () = main |> R.renderTo "main"
