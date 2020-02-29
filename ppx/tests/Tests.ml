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

let[@reaml.component "Foo"] _foo () =
  Js.log "foo";
  let[@reaml] _count, _setCount = Reaml.useState () in
  ()

let[@reaml.component.memo "Foo"] _foo () =
  Js.log "foo";
  let[@reaml] _count, _setCount = Reaml.useState () in
  ()

let[@reaml.hook] useThing _ =
  let[@reaml] count, _setCount = Reaml.useState () in
  let () = Js.log "in useThing!" in
  let[@reaml] value, _dispatch = Reaml.useReducer () () in
  count, value

type foo = { foo : string }

let[@reaml.component.recursive "Foo"] _foo { foo = _ } foo =
  let[@reaml] _count, _setCount = Reaml.useState () in
  let[@reaml] _value, _dispatch = Reaml.useReducer () () in
  let[@reaml] _, _ = useThing () in
  foo { foo = "foo" }

let[@reaml.component.recursive.memo "Foo"] _foo { foo = _ } foo =
  let[@reaml] _count, _setCount = Reaml.useState () in
  let[@reaml] _value, _dispatch = Reaml.useReducer () () in
  let[@reaml] _, _ = useThing () in
  foo { foo = "foo" }

(* Mainly for ReasonML *)
let[@reaml.component "Foo"] _foo () =
  let ((_count, _setCount)[@reaml]) = Reaml.useState () in
  let ((_value, _dispatch)[@reaml]) = Reaml.useReducer () () in
  let ((_, _)[@reaml]) = useThing () in
  ()

module Counter = struct
  type props = { initial : int }

  external make : props -> Reaml.vnode = "Counter"
    [@@bs.module "./Interop.js"] [@@reaml.component]
end
