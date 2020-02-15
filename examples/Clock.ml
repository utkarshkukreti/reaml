module R = Reaml

module Clock = struct
  let make =
   fun [@reaml.component "Clock"] () ->
    let[@reaml] isRunning, setIsRunning = R.useState true in
    let[@reaml] now, setNow = R.useState (Js.Date.make ()) in
    let[@reaml] () = AnimationFrame.use (isRunning, fun _ -> setNow (Js.Date.make ())) in
    let f n = R.string ((if n < 10.0 then "0" else "") ^ Js.Float.toString n) in
    R.h2
      [ R.Style.textAlign "center" ]
      [
        f (Js.Date.getHours now);
        R.string ":";
        f (Js.Date.getMinutes now);
        R.string ":";
        f (Js.Date.getSeconds now);
        R.div []
          [
            R.button
              [ R.onClick (fun _ -> setIsRunning (not isRunning)) ]
              [ R.string (if isRunning then "Stop" else "Start") ];
          ];
      ]
end

let () = Clock.make () |> R.renderTo "main"
