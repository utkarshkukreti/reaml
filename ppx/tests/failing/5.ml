let[@reaml.component "Foo"] _foo () =
  let[@reaml] _count, _setCount = Reaml.useState 0 in
  let[@reaml] () = () in
  ()
