module R = Reaml

module Portal = struct
  let make =
   fun [@reaml.component "Portal"] () ->
    let[@reaml] isOpen, setIsOpen = R.useState false in
    let portal =
      match isOpen, R.find "body" with
      | true, Some body ->
        R.Portal.make
          (R.div
             [ R.Style.position "fixed"; R.Style.top "1rem" ]
             [ R.string "This is a direct child of body!" ])
          body
      | _ -> R.null
    in
    R.div []
      [
        portal;
        R.button [ R.onClick (fun _ -> setIsOpen (not isOpen)) ] [ R.string "Toggle" ];
      ]
end

let main = R.div [] [ Portal.make () ]
let () = main |> R.renderTo "main"
