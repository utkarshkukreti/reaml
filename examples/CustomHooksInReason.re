module R = Reaml;

[@reaml.hook]
let useDoubleReducer = ((reducer, initialValue)) => {
  let[@reaml] (state, dispatch) = R.useReducer(reducer, initialValue);
  let dispatchTwice = action => {
    dispatch(action);
    dispatch(action);
  };

  (state, dispatchTwice);
};

[@reaml.component "CustomHooks"]
let make = () => {
  let reducer = (state, action) => state + action;
  let[@reaml] (state, dispatch) = useDoubleReducer((reducer, 0));
  R.button([R.onClick(_ => dispatch(1))], [R.int(state)]);
};

let main = make();
let () = main |> R.renderTo("main");
