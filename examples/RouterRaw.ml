module R = Reaml

module RouterRaw = struct
  let make =
   fun [@reaml.component "RouterRaw"] () ->
    let[@reaml] url = R.Router.Url.use R.Router.Hash in
    let push string _ =
      R.Router.Url.push R.Router.Hash (R.Router.Url.fromString string)
    in
    let replace string _ =
      R.Router.Url.replace R.Router.Hash (R.Router.Url.fromString string)
    in
    R.div
      [ R.style "textAlign" "center" ]
      [ R.button [ R.onClick (push "/foo") ] [ R.string "PUSH /foo" ]
      ; R.button [ R.onClick (push "/bar") ] [ R.string "PUSH /bar" ]
      ; R.button [ R.onClick (replace "/foo") ] [ R.string "REPLACE /foo" ]
      ; R.button [ R.onClick (replace "/bar") ] [ R.string "REPLACE /bar" ]
      ; R.h3 [] [ R.string (R.Router.Url.toString R.Router.Hash url) ]
      ]
end

let main = RouterRaw.make ()

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
