let _foo =
 fun [@reaml.componnt "Foo"] () ->
  let _ =
   fun () ->
    let[@reaml] () = () in
    ()
  in
  ()
