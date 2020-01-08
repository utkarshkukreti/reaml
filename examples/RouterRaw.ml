module R = Reaml

module RouterRaw = struct
  let make =
   fun [@reaml.component "RouterRaw"] () ->
    let[@reaml] url = R.Router.Url.use Hash in
    let push string _ = R.Router.Url.push Hash (R.Router.Url.fromString string) in
    let replace string _ = R.Router.Url.replace Hash (R.Router.Url.fromString string) in
    R.div
      [ R.style "textAlign" "center" ]
      [ R.button [ R.onClick (push "/foo") ] [ R.string "PUSH /foo" ]
      ; R.button [ R.onClick (push "/bar") ] [ R.string "PUSH /bar" ]
      ; R.button [ R.onClick (replace "/foo") ] [ R.string "REPLACE /foo" ]
      ; R.button [ R.onClick (replace "/bar") ] [ R.string "REPLACE /bar" ]
      ; R.h3 [] [ R.string (R.Router.Url.toString Hash url) ]
      ]
end

let main = RouterRaw.make ()
let () = main |> R.renderTo "main"
