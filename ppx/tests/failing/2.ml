let[@reaml.component "Foo"] _foo () =
  let[@reaml] _count, _setCount = if true then Reaml.useState () else Reaml.useState () in
  ()
