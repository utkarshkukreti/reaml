(* A type for any value *)
type any

external any : 'a -> any = "%identity"

(* A type for JS's `undefined` *)

type undefined

external undefined : undefined = "#undefined"

(* A Reaml Virtual Node *)
type vnode

(* A component of 'props is simply a function from 'props to vnode *)
type 'props component = 'props -> vnode

(* Create a raw element vnode *)
external createElement : string -> 'a Js.Dict.t -> vnode array -> vnode = "createElement"
  [@@bs.variadic] [@@bs.module "react"]

(* Create a raw component element vnode *)
external createComponentElement : 'a component -> 'a -> vnode = "createElement"
  [@@bs.module "react"]

(* A component which requires variadic arguments *)
type ('props, 'child) variadicComponent

(* Create a raw variadic component element vnode *)
external createVariadicComponentElement
  :  ('props, 'child) variadicComponent ->
  'props ->
  'child array ->
  vnode
  = "createElement"
  [@@bs.variadic] [@@bs.module "react"]

(* Set the display name of a component *)
external setDisplayName : 'a component -> string -> unit = "displayName" [@@bs.set]

(* React.Fragment, for internal use *)
external _fragment : (unit, vnode) variadicComponent = "Fragment" [@@bs.module "react"]

(* React.memo'ize a component *)
external memo : 'a component -> 'a component = "memo" [@@bs.module "react"]

(* Functions to create `any array option` from given values. *)
(* Values of this type are accepted by several functions below. *)

let _0 = Some ([||] : any array)
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

  and 'a props = {
    value : 'a;
    children : vnode;
  }

  external make : 'a -> 'a t = "createContext" [@@bs.module "react"]

  let provide (context : 'a t) (value : 'a) vnode =
    createComponentElement context.provider { value; children = vnode }
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
  :  (unit -> 'a) ->
  (undefined[@bs.ignore]) ->
  'a * (('a -> 'a) -> unit)
  = "useState"
  [@@bs.module "react"]

(* Reducer *)
external useReducer
  :  ('state -> 'action -> 'state) ->
  'state ->
  (undefined[@bs.ignore]) ->
  'state * ('action -> unit)
  = "useReducer"
  [@@bs.module "react"]

let useState : 'a -> undefined -> 'a * ('a -> unit) =
  let reducer _state action = action in
  fun state undefined -> useReducer reducer state undefined

external useReducerLazy
  :  ('state -> 'action -> 'state) ->
  'a ->
  ('a -> 'state) ->
  (undefined[@bs.ignore]) ->
  'state * ('action -> unit)
  = "useReducer"
  [@@bs.module "react"]

(* Effect *)
external useEffect
  :  (unit -> (unit -> unit) option) ->
  any array option ->
  (undefined[@bs.ignore]) ->
  unit
  = "useEffect"
  [@@bs.module "react"]

(* Layout Effect *)
external useLayoutEffect
  :  (unit -> (unit -> unit) option) ->
  any array option ->
  (undefined[@bs.ignore]) ->
  unit
  = "useLayoutEffect"
  [@@bs.module "react"]

(* Callback *)
type ('a, 'b) callback = 'a -> 'b

external useCallback
  :  ('a, 'b) callback ->
  any array option ->
  (undefined[@bs.ignore]) ->
  ('a, 'b) callback
  = "useCallback"
  [@@bs.module "react"]

(* Memo *)
external useMemo
  :  (unit -> 'a) ->
  any array option ->
  (undefined[@bs.ignore]) ->
  'a
  = "useMemo"
  [@@bs.module "react"]

(* Context *)
external useContext : 'a Context.t -> (undefined[@bs.ignore]) -> 'a = "useContext"
  [@@bs.module "react"]

(* Ref *)
external useRef : 'a -> (undefined[@bs.ignore]) -> 'a Ref.t = "useRef"
  [@@bs.module "react"]

(* Element Attribute *)
type attr =
  | Property of string * any
  | Style of string * string
  | Class of string
  | List of attr list

(* Property Constructors *)
let property name value = Property (name, any value)
let on name (value : Reaml_Event.Event.t -> unit) = Property ("on" ^ name, any value)
let style name value = Style (name, value)
let class_ name = Class name
let data name value = Property ("data-" ^ name, any value)
let aria name value = Property ("aria-" ^ name, any value)
let key (value : string) = Property ("key", any value)
let keyInt (value : int) = Property ("key", any value)
let attrs attrs = List attrs

type dangerouslySetInnerHtml = { __html : string }

let dangerouslySetInnerHtml html =
  Property ("dangerouslySetInnerHTML", any { __html = html })

(* Create Empty Node *)
external null : vnode = "#null"

(* Create Element Node *)
let elementArray name attrs (children : vnode array) =
  let attrs_ = Js.Dict.empty () in
  let style = Js.Dict.empty () in
  let hasStyle = ref false in
  let class_ = ref "" in
  let rec go = function
    | Property (name, value) -> Js.Dict.set attrs_ name value
    | Style (name, value) ->
      hasStyle := true;
      Js.Dict.set style name value
    | Class name -> class_ := if !class_ = "" then name else !class_ ^ " " ^ name
    | List attrs -> Belt.List.forEach attrs go
  in
  Belt.List.forEach attrs go;
  if !hasStyle then Js.Dict.set attrs_ "style" (any style) else ();
  if !class_ = "" then () else Js.Dict.set attrs_ "className" (any !class_);
  createElement name attrs_ children

let element name attrs (children : vnode list) =
  elementArray name attrs (Belt.List.toArray children)

(* Create Text Node *)
external string : string -> vnode = "%identity"
external int : int -> vnode = "%identity"
external float : float -> vnode = "%identity"

(* Create From List/Array *)
external array : vnode array -> vnode = "%identity"

let list list = array (Belt.List.toArray list)

(* Create a Fragment *)
let fragmentArray (array : vnode array) =
  createVariadicComponentElement _fragment () array

let fragment list = fragmentArray (Belt.List.toArray list)

(* Create Component *)
let component ?memo:(memo_ = false) name fn =
  setDisplayName fn name;
  let fn = if memo_ then memo fn else fn in
  fun props -> createComponentElement fn props

(* Create Recursive Component *)
let recursiveComponent ?memo:(memo_ = false) name fn =
  let _ = memo in
  let rec fn_ x = fn x (fun props -> createComponentElement fn_ props) in
  setDisplayName fn_ name;
  let fn_ = if memo_ then memo fn_ else fn_ in
  fun props -> createComponentElement fn_ props

(* Portal *)
module Portal = struct
  external make : vnode -> Dom.element -> vnode = "createPortal" [@@bs.module "react-dom"]
end

(* Render *)
external render : vnode -> Dom.element -> unit = "render" [@@bs.module "react-dom"]

(* Utility *)
external find : string -> Dom.element option = "querySelector"
  [@@bs.val] [@@bs.scope "document"] [@@bs.return nullable]

let renderTo selector vnode =
  match find selector with
  | Some element -> render vnode element
  | None -> Js.Console.error ("no element matching selector `" ^ selector ^ "` found")
