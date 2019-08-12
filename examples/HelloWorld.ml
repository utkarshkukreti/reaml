module R = Reaml

let main = R.h1 [ R.id "hello" ] [ R.string "Hello, world!" ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
