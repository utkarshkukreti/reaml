module R = Reaml
module S = R.Svg

module Clock = struct
  let utcNow () =
    Js.Date.now () -. (Js.Date.getTimezoneOffset (Js.Date.make ()) *. 60.0 *. 1000.0)

  let make =
   fun [@reaml.component "Clock"] () ->
    let[@reaml] isRunning, setIsRunning = R.useState true in
    let[@reaml] now, setNow = R.useState (Js.Date.now ()) in
    let[@reaml] () = AnimationFrame.use (isRunning, fun _ -> setNow (utcNow ())) in
    let circle =
      S.circle [ S.cx "100"; S.cy "100"; S.r "98"; S.fill "none"; S.stroke "black" ] []
    in
    let line rotate stroke strokeWidth height =
      S.line
        [ S.x1 "100"
        ; S.y1 "100"
        ; S.x2 (Js.Int.toString (100 - height))
        ; S.y2 "100"
        ; S.stroke stroke
        ; S.strokeWidth (Js.Int.toString strokeWidth)
        ; S.strokeLinecap "round"
        ; S.transform ("rotate(" ^ Js.Float.toString rotate ^ " 100 100)")
        ]
        []
    in
    let s = now /. 1000.0 in
    let secondRotate = 90.0 +. (mod_float s 60.0 *. 360.0 /. 60.0) in
    let minuteRotate = 90.0 +. (mod_float (s /. 60.0) 60.0 *. 360.0 /. 60.0) in
    let hourRotate = 90.0 +. (mod_float (s /. 60.0 /. 60.0) 12.0 *. 360.0 /. 12.0) in
    R.h2
      [ R.style "textAlign" "center" ]
      [ S.svg
          [ S.width "400"; S.height "400"; S.viewBox "0 0 200 200" ]
          [ circle
          ; line hourRotate "#333" 4 50
          ; line minuteRotate "#333" 3 70
          ; line secondRotate "crimson" 2 90
          ]
      ; R.div
          []
          [ R.button
              [ R.onClick (fun _ -> setIsRunning (not isRunning)) ]
              [ R.string (if isRunning then "Stop" else "Start") ]
          ]
      ]
end

let () =
  match R.find "main" with
  | Some element -> R.render (Clock.make ()) element
  | None -> Js.Console.error "<main> not found!"
