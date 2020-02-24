let _foo =
 fun [@reaml.component "Foo"] () ->
  if true
  then (
    let[@reaml] _count, _setCount = Reaml.useState () in
    ())
  else ()
