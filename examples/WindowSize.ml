module R = Reaml

module WindowSize = struct
  type t =
    { width : float
    ; height : float
    }

  external innerWidth : float = "innerWidth" [@@bs.val] [@@bs.scope "window"]
  external innerHeight : float = "innerHeight" [@@bs.val] [@@bs.scope "window"]

  external addEventListener : string -> (unit -> unit) -> unit = "addEventListener"
    [@@bs.val] [@@bs.scope "window"]

  external removeEventListener : string -> (unit -> unit) -> unit = "removeEventListener"
    [@@bs.val] [@@bs.scope "window"]

  let use =
   fun [@reaml.hook] () ->
    let[@reaml] size, setSize = R.useState { width = innerWidth; height = innerHeight } in
    let[@reaml] () =
      R.useEffect
        (fun () ->
          let handler () = setSize { width = innerWidth; height = innerHeight } in
          addEventListener "resize" handler;
          Some (fun () -> removeEventListener "resize" handler))
        None
    in
    size
end

module Demo = struct
  let make =
   fun [@reaml.component "Demo"] () ->
    let[@reaml] windowSize = WindowSize.use () in
    R.div [] [ R.float windowSize.width; R.string " "; R.float windowSize.height ]
end

let () =
  match R.find "main" with
  | Some element -> R.render (Demo.make ()) element
  | None -> Js.Console.error "<main> not found!"
