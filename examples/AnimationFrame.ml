module R = Reaml

let use =
 fun [@reaml.hook] (enabled, func) ->
  let[@reaml] funcRef = R.useRef func in
  let[@reaml] () =
    R.useEffect
      (fun () ->
        R.Ref.write funcRef func;
        None)
      (R._1 func)
  in
  let[@reaml] () =
    R.useEffect
      (fun () ->
        let isRunning = ref enabled in
        let rec loop t =
          if !isRunning
          then (
            (R.Ref.read funcRef) t;
            Webapi.requestAnimationFrame loop)
          else ()
        in
        Webapi.requestAnimationFrame loop;
        Some (fun () -> isRunning := false))
      (R._1 enabled)
  in
  ()
