module R = Reaml

module Counter = struct
  type props = { initial : int }

  external make : props Reaml.component = "Counter"
    [@@bs.module "./Interop.js"] [@@reaml.component]
end

let main =
  R.div []
    [
      Counter.make { initial = -3 };
      Counter.make { initial = 0 };
      Counter.make { initial = 3 };
    ]

let () = main |> R.renderTo "main"
