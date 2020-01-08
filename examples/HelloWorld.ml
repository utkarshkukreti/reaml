module R = Reaml

let main = R.h1 [ R.id "hello" ] [ R.string "Hello, world!" ]
let () = main |> R.renderTo "main"
