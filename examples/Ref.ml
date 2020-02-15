module R = Reaml

module Ref = struct
  let make =
   fun [@reaml.component "Ref"] () ->
    let[@reaml] show, setShow = R.useState true in
    let[@reaml] inputRef = R.useRef None in
    let focus () =
      match R.Ref.read inputRef with
      | Some el ->
        Webapi.Dom.(
          (match Element.asHtmlElement el with
          | Some el -> HtmlElement.focus el
          | None -> ()))
      | None -> ()
    in
    R.div []
      [
        R.button [ R.onClick (fun _ -> setShow (not show)) ] [ R.string "Toggle" ];
        R.button [ R.onClick (fun _ -> focus ()) ] [ R.string "Focus" ];
        (if show then R.input [ R.ref (R.Ref.write inputRef) ] [] else R.null);
      ]
end

let main = Ref.make ()
let () = main |> R.renderTo "main"
