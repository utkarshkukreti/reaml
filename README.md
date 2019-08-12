# Reaml (React + ML)

> An opinionated React binding for (OCaml | ReasonML) + BuckleScript with
> compile time enforcement of the ["Rules of Hooks"](https://reactjs.org/docs/hooks-rules.html)
> ([How?](#how-are-the-rules-of-hooks-enforced-at-compile-time)).

> [Live Demos](https://reaml.netlify.com) | [Starter](https://github.com/utkarshkukreti/reaml-starter)

## Overview

The "Hello, World!" of Reaml looks like this:

```ocaml
module R = Reaml

let main = R.h1 [ R.id "hello" ] [ R.string "Hello, world!" ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
```

The code above renders `<h1 id="hello">Hello, World!</h1>` into the first
element on the page matching the selector `main`.

Note: If you want to use ReasonML syntax instead of OCaml, check out the
[last section](#reasonml) for the equivalent ReasonML code.

---

Components are defined using a syntax extension
`[@reaml.component "DisplayNameOfComponent"]` applied to `fun`s of one argument:

```ocaml
module R = Reaml

module Counter = struct
  let make =
   fun [@reaml.component "Counter"] initial ->
    R.div [] [R.int initial]
end
```

Components are initialized using simple function calls:

```ocaml
let main = Counter.make 0
```

Hooks are invoked using a `[@reaml]` annotation on `let` expressions:

```ocaml
let make =
 fun [@reaml.component "Counter"] initial ->
  let[@reaml] count, setCount = R.useState initial in
  R.div [] [R.int initial]
```

Here's a full example of a Counter with two buttons, one to increment and one to
decrement the value ([full source](examples/Counter.ml)):

```ocaml
module Counter = struct
  let make =
   fun [@reaml.component "Counter"] initial ->
    let[@reaml] count, setCount = R.useState initial in
    R.div
      []
      [ R.button [ R.onClick (fun _ -> setCount (count - 1)) ] [ R.string "-" ]
      ; R.string " "
      ; R.int count
      ; R.string " "
      ; R.button [ R.onClick (fun _ -> setCount (count + 1)) ] [ R.string "+" ]
      ]
end
```

Custom hooks are created using a syntax extension `[@reaml.hook]` applied to
`fun`s of one argument. Here's a custom hook that wraps `useReducer`, invoking
any action dispatched twice instead of once.

```ocaml
let useDoubleReducer =
 fun [@reaml.hook] (reducer, initialValue) ->
  let[@reaml] state, dispatch = R.useReducer reducer initialValue in
  let dispatchTwice action =
    dispatch action;
    dispatch action
  in
  state, dispatchTwice
```

These custom hooks are called in the same manner as the built-in hooks -- using
`let[@reaml]`:

```ocaml
let make =
 fun [@reaml.component "CustomHooks"] () ->
  let reducer state action = state + action in
  let[@reaml] state, dispatch = useDoubleReducer (reducer, 0) in
  R.button [ R.onClick (fun _ -> dispatch 2) ] [ R.int state ]
```

Full example [here](examples/CustomHooks.ml).

## Quick Start

    $ git clone https://github.com/utkarshkukreti/reaml-starter
    $ cd reaml-starter
    $ yarn install
    $ yarn build

This will build `/src/Main.ml` into the `/dist/` directory which you can run by
opening `/index.html` in your browser.

Feel free to copy code from [examples](/examples) into `src/Main.ml` and
recompile.

## How are the Rules of Hooks enforced at compile time?

Reaml uses an OCaml syntax extension to enforce them.

This requires annotating components with `fun [@reaml.component]`,
custom hooks with `fun [@reaml.hook]`, and every use of a hook with
`let[@reaml]`.

For `[@reaml.hook]`, the syntax extension appends a dummy argument to the
function, the value of which must be of type `Reaml.undefined` (represented as
plain `undefined` in JS).

For both `[@reaml.hook]` and `[@reaml.component]`, the syntax extension
traverses the top level `let` expressions and rewrites `let[@reaml]`
expressions, appending the `undefined` value to the function call on the right.

If you call a hook without `let[@reaml]`, you will get a type check error due to
a missing argument.

After all this is done, the syntax extension traverses the whole program and
checks whether any of these annotations were not processed and throws an error
if it finds any because it means the annotation was incorrectly used.

For more examples, check out the files under [/examples](examples).
A live demo of all the examples is available
[here](https://reaml.netlify.com).

## ReasonML

Here's the Hello World example in ReasonML:

```reason
module R = Reaml;

let main = R.h1([R.id("hello")], [R.string("Hello, world!")]);

switch (R.find("main")) {
| Some(element) => R.render(main, element)
| None => Js.Console.error("<main> not found!")
};
```

Here's an example of ReasonML code which uses all the three annotations that
this library uses:

```reason
module R = Reaml;

let useDoubleReducer =
  [@reaml.hook]
  (
    ((reducer, initialValue)) => {
      let [@reaml] (state, dispatch) = R.useReducer(reducer, initialValue);
      let dispatchTwice = action => {
        dispatch(action);
        dispatch(action);
      };
      (state, dispatchTwice);
    }
  );

let make =
  [@reaml.component "CustomHooks"]
  (
    () => {
      let reducer = (state, action) => state + action;
      let [@reaml] (state, dispatch) = useDoubleReducer((reducer, 0));
      R.button([R.onClick(_ => dispatch(2))], [R.int(state)]);
    }
  );

let main = make();
switch (R.find("main")) {
| Some(element) => R.render(main, element)
| None => Js.Console.error("<main> not found!")
};
```

For more guidance on how to translate OCaml code into ReasonML, try pasting the
OCaml code in the [Try ReasonML](https://reasonml.github.io/en/try) page or read
[this guide](https://reasonml.github.io/docs/en/comparison-to-ocaml).

## License

MIT
