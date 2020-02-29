let[@reaml.component "Foo"] _foo () =
  let _ =
   fun () ->
    let[@reaml] () = () in
    ()
  in
  ()
