module R = Reaml

module Theme = struct
  type t =
    | Red
    | Green
    | Blue

  let toString = function
    | Red -> "Red"
    | Green -> "Green"
    | Blue -> "Blue"
end

let theme = R.Context.make Theme.Red

module Hello = struct
  let[@reaml.component "Hello"] make () =
    let[@reaml] theme = R.useContext theme in
    R.div [ R.Style.color (Theme.toString theme) ] [ R.string (Theme.toString theme) ]
end

let main =
  R.div []
    [
      Hello.make ();
      R.Context.provide theme Green (R.div [] [ Hello.make (); Hello.make () ]);
      R.Context.provide theme Blue (Hello.make ());
    ]

let () = main |> R.renderTo "main"
