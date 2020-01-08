module R = Reaml

module Router = struct
  type t =
    | Home
    | Posts
    | Post of int

  let toString = function
    | Home -> "Home"
    | Posts -> "Posts"
    | Post id -> "(Post " ^ Js.Int.toString id ^ ")"

  include R.Router.Make (struct
    type nonrec t = t

    let mode = R.Router.Hash

    let parse =
      R.Router.Parser.(
        parse
          (oneOf
             [ root Home
             ; s "posts" |> map Posts
             ; s "posts" </> int |> map (fun id -> Post id)
             ]))

    let build =
      R.Router.Builder.(
        function
        | Home -> root
        | Posts -> root </> "posts"
        | Post id -> root </> "posts" </> int id)
  end)
end

module Router_ = struct
  let make =
   fun [@reaml.component "Router"] () ->
    let[@reaml] route = Router.use () in
    let push t _ = Router.push t in
    let replace t _ = Router.replace t in
    R.div
      [ R.style "textAlign" "center" ]
      [ R.button [ R.onClick (push Home) ] [ R.string "PUSH Home" ]
      ; R.button [ R.onClick (push Posts) ] [ R.string "PUSH Posts" ]
      ; R.button [ R.onClick (push (Post 123)) ] [ R.string "PUSH Post 123" ]
      ; R.button [ R.onClick (push (Post 456)) ] [ R.string "PUSH Post 456" ]
      ; R.br [] []
      ; R.button [ R.onClick (replace Home) ] [ R.string "REPLACE Home" ]
      ; R.button [ R.onClick (replace Posts) ] [ R.string "REPLACE Posts" ]
      ; R.button [ R.onClick (replace (Post 123)) ] [ R.string "REPLACE Post 123" ]
      ; R.button [ R.onClick (replace (Post 456)) ] [ R.string "REPLACE Post 456" ]
      ; R.br [] []
      ; Router.link Home [] [ R.string "LINK Home" ]
      ; R.string " "
      ; Router.link Posts [] [ R.string "LINK Posts" ]
      ; R.string " "
      ; Router.link (Post 123) [] [ R.string "LINK Post 123" ]
      ; R.string " "
      ; Router.link (Post 456) [] [ R.string "LINK Post 456" ]
      ; R.h3
          []
          [ R.string
              (match route with
              | Some route -> "Some " ^ Router.toString route
              | None -> "None")
          ]
      ]
end

let main = Router_.make ()
let () = main |> R.renderTo "main"
