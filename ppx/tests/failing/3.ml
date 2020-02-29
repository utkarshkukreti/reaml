let[@reaml.component "Foo"] _foo () =
  if true
  then (
    let[@reaml] _count, _setCount = Reaml.useState () in
    ())
  else ()
