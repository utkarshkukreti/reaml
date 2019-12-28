(* A type for any value *)
type any

external any : 'a -> any = "%identity"

(* A type for JS's `undefined` *)

type undefined

external undefined : undefined = "#undefined"

(* A DOM Element *)
type element

(* A Reaml Virtual Node *)
type vnode

(* A component of 'props is simply a function from 'props to vnode *)
type 'props component = 'props -> vnode

module Internal = struct
  external createElement : string -> 'a -> vnode array -> vnode = "createElement"
    [@@bs.variadic] [@@bs.module "react"]

  external createComponentElement : 'a component -> 'a -> vnode = "createElement"
    [@@bs.module "react"]

  external fragment : vnode array -> vnode = "%identity"
  external setDisplayName : 'a component -> string -> unit = "displayName" [@@bs.set]
end

(* Functions to create `any array option` from given values. *)
(* Values of this type are accepted by several functions below. *)

let _0 = Some [||]
let _1 a = Some [| any a |]
let _2 a b = Some [| any a; any b |]
let _3 a b c = Some [| any a; any b; any c |]
let _4 a b c d = Some [| any a; any b; any c; any d |]
let _5 a b c d e = Some [| any a; any b; any c; any d; any e |]
let _6 a b c d e f = Some [| any a; any b; any c; any d; any e; any f |]
let _7 a b c d e f g = Some [| any a; any b; any c; any d; any e; any f; any g |]

(* Context *)
module Context = struct
  type 'a t = { provider : 'a props -> vnode [@bs.as "Provider"] }

  and 'a props =
    { value : 'a
    ; children : vnode
    }

  external make : 'a -> 'a t = "createContext" [@@bs.module "react"]

  let provide (context : 'a t) (value : 'a) vnode =
    Internal.createComponentElement context.provider { value; children = vnode }
end

(* Ref *)
module Ref = struct
  type 'a t

  external read : 'a t -> 'a = "current" [@@bs.get]
  external write : 'a t -> 'a -> unit = "current" [@@bs.set]
end

(* Hooks *)

(* State *)
external useStateLazy
  :  (unit -> 'a)
  -> undefined
  -> 'a * (('a -> 'a) -> unit)
  = "useState"
  [@@bs.module "react"]

(* Reducer *)
external useReducer
  :  ('state -> 'action -> 'state)
  -> 'state
  -> undefined
  -> 'state * ('action -> unit)
  = "useReducer"
  [@@bs.module "react"]

let useState : 'a -> undefined -> 'a * ('a -> unit) =
  let reducer _state action = action in
  fun state undefined -> useReducer reducer state undefined

external useReducerLazy
  :  ('state -> 'action -> 'state)
  -> 'a
  -> ('a -> 'state)
  -> undefined
  -> 'state * ('action -> unit)
  = "useReducer"
  [@@bs.module "react"]

(* Effect *)
external useEffect
  :  (unit -> (unit -> unit) option)
  -> any array option
  -> undefined
  -> unit
  = "useEffect"
  [@@bs.module "react"]

(* Layout Effect *)
external useLayoutEffect
  :  (unit -> (unit -> unit) option)
  -> any array option
  -> undefined
  -> unit
  = "useLayoutEffect"
  [@@bs.module "react"]

(* Callback *)
type ('a, 'b) callback = 'a -> 'b

external useCallback
  :  ('a, 'b) callback
  -> any array option
  -> undefined
  -> ('a, 'b) callback
  = "useCallback"
  [@@bs.module "react"]

(* Memo *)
external useMemo : (unit -> 'a) -> any array option -> undefined -> 'a = "useMemo"
  [@@bs.module "react"]

(* Context *)
external useContext : 'a Context.t -> undefined -> 'a = "useContext" [@@bs.module "react"]

(* Ref *)
external useRef : 'a -> undefined -> 'a Ref.t = "useRef" [@@bs.module "react"]

(* Prop *)
type prop =
  | Property of string * any
  | Style of string * string
  | Class of string

(* Prop Constructors *)
let property name value = Property (name, any value)
let on name (value : Reaml_Event.Event.t -> unit) = Property ("on" ^ name, any value)
let style name value = Style (name, value)
let class' name = Class name
let data name value = Property ("data-" ^ name, any value)
let aria name value = Property ("aria-" ^ name, any value)

let classes (pairs : (string * bool) list) =
  Class
    (pairs
    |. Belt.List.keepMap (function
           | name, true -> Some name
           | _ -> None)
    |. Belt.List.toArray
    |> Js.Array.joinWith " ")

(* Create Empty Node *)
external null : vnode = "#null"

(* Create Element Node *)
let element name props (children : vnode list) =
  let props' = Js.Dict.empty () in
  let style = Js.Dict.empty () in
  let hasStyle = ref false in
  let class' = ref "" in
  Belt.List.forEach props (function
      | Property (name, value) -> Js.Dict.set props' name value
      | Style (name, value) ->
        hasStyle := true;
        Js.Dict.set style name value
      | Class name -> class' := if !class' = "" then name else !class' ^ " " ^ name);
  if !hasStyle then Js.Dict.set props' "style" (any style) else ();
  if !class' = "" then () else Js.Dict.set props' "className" (any !class');
  Internal.createElement name props' (Belt.List.toArray children)

(* Create Text Node *)
external string : string -> vnode = "%identity"
external int : int -> vnode = "%identity"
external float : float -> vnode = "%identity"

(* Create Fragment *)
let fragment list = Internal.fragment (Belt.List.toArray list)

(* Create Component *)
let component name fn =
  Internal.setDisplayName fn name;
  fun props -> Internal.createComponentElement fn props

(* Create Recursive Component *)
let recursiveComponent name fn =
  let rec fn' x = fn x (fun props -> Internal.createComponentElement fn' props) in
  Internal.setDisplayName fn' name;
  fun props -> Internal.createComponentElement fn' props

(* Render *)
external render : vnode -> element -> unit = "render" [@@bs.module "react-dom"]

(* Utility *)
external find : string -> element option = "querySelector"
  [@@bs.val] [@@bs.scope "document"] [@@bs.return nullable]
