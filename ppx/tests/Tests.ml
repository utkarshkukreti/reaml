module Reaml = struct
  type undefined
  type vnode

  let undefined : undefined = Obj.magic ()
  let useState _ _ = Obj.magic ()
  let useReducer _ _ _ = Obj.magic ()
  let component _ _ = Obj.magic ()
  let recursiveComponent _ _ = Obj.magic ()
  let createComponentElement _ _ = Obj.magic ()
end

type props = { foo : int }

external _foo : props -> Reaml.vnode = "foo" [@@reaml.component] [@@bs.val]

let _foo =
 fun [@reaml.component "Foo"] () ->
  Js.log "foo";
  let[@reaml] _count, _setCount = Reaml.useState () in
  ()

let _foo =
 fun [@reaml.component.memo "Foo"] () ->
  Js.log "foo";
  let[@reaml] _count, _setCount = Reaml.useState () in
  ()

let useThing =
 fun [@reaml.hook] _ ->
  let[@reaml] count, _setCount = Reaml.useState () in
  let () = Js.log "in useThing!" in
  let[@reaml] value, _dispatch = Reaml.useReducer () () in
  count, value

type foo = { foo : string }

let _foo =
 fun [@reaml.component.recursive "Foo"] { foo = _ } foo ->
  let[@reaml] _count, _setCount = Reaml.useState () in
  let[@reaml] _value, _dispatch = Reaml.useReducer () () in
  let[@reaml] _, _ = useThing () in
  foo { foo = "foo" }

let _foo =
 fun [@reaml.component.recursive.memo "Foo"] { foo = _ } foo ->
  let[@reaml] _count, _setCount = Reaml.useState () in
  let[@reaml] _value, _dispatch = Reaml.useReducer () () in
  let[@reaml] _, _ = useThing () in
  foo { foo = "foo" }

(* Mainly for ReasonML *)
let _foo =
 fun [@reaml.component "Foo"] () ->
  let ((_count, _setCount)[@reaml]) = Reaml.useState () in
  let ((_value, _dispatch)[@reaml]) = Reaml.useReducer () () in
  let ((_, _)[@reaml]) = useThing () in
  ()

module Counter = struct
  type props = { initial : int }

  external make : props -> Reaml.vnode = "Counter"
    [@@bs.module "./Interop.js"] [@@reaml.component]
end

(* These should produce errors. *)

(* let _foo _ =
  let[@reaml] _ = () in
  () *)

(* let _foo =
 fun [@reaml.component "Foo"] () ->
  let[@reaml] _count, _setCount = if true then Reaml.useState () else Reaml.useState () in
  () *)

(* let _foo =
 fun [@reaml.component "Foo"] () ->
  if true
  then (
    let[@reaml] _count, _setCount = Reaml.useState () in
    ())
  else () *)

(* let _foo =
 fun [@reaml.component "Foo"] () ->
  let[@reaml] () = () in
  () *)

(* let _foo =
 fun [@reaml.component "Foo"] () ->
  let[@reaml] _count, _setCount = Reaml.useState 0 in
  let[@reaml] () = () in
  () *)

(* let _foo =
 fun [@reaml.component "Foo"] () ->
  let _ =
   fun () ->
    let[@reaml] () = () in
    ()
  in
  () *)
