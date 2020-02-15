type mode =
  | History
  | Hash

module Url = struct
  type t = { path : string list }

  let fromString string =
    let path =
      string
      |> Js.String.split "/"
      |. Belt.Array.keep (fun x -> x <> "")
      |. Belt.List.fromArray
    in
    { path }

  let toString mode url =
    (match mode with
    | Hash -> "#"
    | History -> "")
    ^ "/"
    ^ Js.Array.joinWith "/" (Belt.List.toArray url.path)

  let use mode (_ : Reaml_Core.undefined) =
    let get () =
      Webapi.Dom.(
        match mode with
        | History -> location |> Location.pathname
        | Hash -> location |> Location.hash |> Js.String.sliceToEnd ~from:1)
      |> fromString
    in
    let url, setUrl = Reaml_Core.useState (get ()) Reaml_Core.undefined in
    Reaml_Core.useEffect
      (fun () ->
        let f _ =
          let url_ = get () in
          if url = url_ then () else setUrl url_
        in
        Webapi.Dom.window |> Webapi.Dom.Window.addEventListener "popstate" f;
        Some
          (fun () ->
            Webapi.Dom.window |> Webapi.Dom.Window.removeEventListener "popstate" f))
      None
      Reaml_Core.undefined;
    url

  let dispatch () =
    Webapi.Dom.window
    |> Webapi.Dom.Window.dispatchEvent (Webapi.Dom.Event.make "popstate")
    |> ignore

  let push mode t =
    Webapi.Dom.(
      history |> History.pushState (History.state history) "" (t |> toString mode));
    dispatch ()

  let replace mode t =
    Webapi.Dom.(
      history |> History.replaceState (History.state history) "" (t |> toString mode));
    dispatch ()
end

module Parser = struct
  type 'a state = {
    url : Url.t;
    value : 'a;
  }

  type ('a, 'b) t = Parser of ('a state -> 'b state list)

  let root value = Parser (fun state -> [ { state with value } ])

  let string =
    Parser
      (fun state ->
        match state.url.path with
        | first :: rest -> [ { url = { path = rest }; value = state.value first } ]
        | [] -> [])

  let int =
    Parser
      (fun state ->
        match state.url.path with
        | first :: rest ->
          (try
             [ { url = { path = rest }; value = state.value (int_of_string first) } ]
           with
          | _ -> [])
        | _ -> [])

  let s string =
    Parser
      (fun state ->
        match state.url.path with
        | first :: rest when first == string -> [ { state with url = { path = rest } } ]
        | _ -> [])

  let ( </> ) (Parser a) (Parser b) =
    Parser (fun state -> Belt.List.map (a state) b |. Belt.List.flatten)

  let oneOf parsers =
    Parser
      (fun state ->
        parsers |. Belt.List.map (fun (Parser p) -> p state) |. Belt.List.flatten)

  let map value (Parser p) =
    Parser
      (fun state ->
        p { state with value }
        |. Belt.List.map (fun state_ -> { state_ with value = state.value state_.value }))

  let parse (Parser p) url =
    let state = { url; value = (fun x -> x) } in
    let rec get = function
      | { url = { path = [] }; value } :: _ -> Some value
      | _ :: rest -> get rest
      | _ -> None
    in
    get (p state)
end

module Builder = struct
  let root = Url.{ path = [] }
  let ( </> ) url segment = Url.{ path = url.path @ [ segment ] }
  let int = Js.Int.toString
end

module type Spec = sig
  type t

  val mode : mode
  val parse : Url.t -> t option
  val build : t -> Url.t
end

module Make (S : Spec) = struct
  let mode = S.mode
  let parse = S.parse
  let build = S.build

  let link t props children =
    Reaml_Html.a (Reaml_Html.href (t |> build |> Url.toString S.mode) :: props) children

  let use () (_ : Reaml_Core.undefined) =
    let url = Url.use mode Reaml_Core.undefined in
    parse url

  let push t = t |> build |> Url.push mode
  let replace t = t |> build |> Url.replace mode
end
