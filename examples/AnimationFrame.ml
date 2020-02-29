module R = Reaml

let[@reaml.hook] use (enabled, callback) =
  let[@reaml] callbackRef = R.useRef callback in
  let[@reaml] () =
    R.useEffect
      (fun () ->
        R.Ref.write callbackRef callback;
        None)
      (R._1 callback)
  in
  let[@reaml] () =
    R.useEffect
      (fun () ->
        let isRunning = ref enabled in
        let rec loop t =
          if !isRunning
          then (
            (R.Ref.read callbackRef) t;
            Webapi.requestAnimationFrame loop)
          else ()
        in
        Webapi.requestAnimationFrame loop;
        Some (fun () -> isRunning := false))
      (R._1 enabled)
  in
  ()
