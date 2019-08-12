module R = Reaml

let useDoubleReducer =
 fun [@reaml.hook] (reducer, initialValue) ->
  let[@reaml] state, dispatch = R.useReducer reducer initialValue in
  let dispatchTwice action =
    dispatch action;
    dispatch action
  in
  state, dispatchTwice

let make =
 fun [@reaml.component "CustomHooks"] () ->
  let reducer state action = state + action in
  let[@reaml] state, dispatch = useDoubleReducer (reducer, 0) in
  R.button [ R.onClick (fun _ -> dispatch 1) ] [ R.int state ]

let main = make ()

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
