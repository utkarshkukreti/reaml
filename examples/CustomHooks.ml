module R = Reaml

let[@reaml.hook] useDoubleReducer (reducer, initialValue) =
  let[@reaml] state, dispatch = R.useReducer reducer initialValue in
  let dispatchTwice action =
    dispatch action;
    dispatch action
  in
  state, dispatchTwice

let[@reaml.component "CustomHooks"] make () =
  let reducer state action = state + action in
  let[@reaml] state, dispatch = useDoubleReducer (reducer, 0) in
  R.button [ R.onClick (fun _ -> dispatch 1) ] [ R.int state ]

let main = make ()
let () = main |> R.renderTo "main"
