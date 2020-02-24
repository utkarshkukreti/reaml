let _foo =
 fun [@reaml.component "Foo"] () ->
  let _ =
   fun () ->
    let[@reaml] () = () in
    ()
  in
  ()
