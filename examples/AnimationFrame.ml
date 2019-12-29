module R = Reaml

let use =
 fun [@reaml.hook] (enabled, func) ->
  let[@reaml] () =
    R.useEffect
      (fun () ->
        let isRunning = ref enabled in
        let rec loop t =
          if !isRunning
          then (
            func t;
            Webapi.requestAnimationFrame loop)
          else ()
        in
        Webapi.requestAnimationFrame loop;
        Some (fun () -> isRunning := false))
      (R._1 enabled)
  in
  ()
