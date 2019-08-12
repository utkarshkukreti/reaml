module R = Reaml

let use =
 fun [@reaml.hook] (enabled, func) ->
  let[@reaml] () =
    R.useEffect
      (fun () ->
        let id = ref None in
        let rec loop t =
          func t;
          id := Some (Webapi.requestCancellableAnimationFrame loop);
          ()
        in
        if enabled then id := Some (Webapi.requestCancellableAnimationFrame loop) else ();
        Some
          (fun () ->
            match !id with
            | Some id -> Webapi.cancelAnimationFrame id
            | None -> ()))
      (R._1 enabled)
  in
  ()
