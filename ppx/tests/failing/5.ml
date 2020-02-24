let _foo =
 fun [@reaml.component "Foo"] () ->
  let[@reaml] _count, _setCount = Reaml.useState 0 in
  let[@reaml] () = () in
  ()
