let _foo =
 fun [@reaml.component "Foo"] () ->
  let[@reaml] _count, _setCount = if true then Reaml.useState () else Reaml.useState () in
  ()
