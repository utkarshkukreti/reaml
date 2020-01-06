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
             [ R.style "position" "fixed"; R.style "top" "1rem" ]
             [ R.string "This is a direct child of body!" ])
          body
      | _ -> R.null
    in
    R.div
      []
      [ portal
      ; R.button [ R.onClick (fun _ -> setIsOpen (not isOpen)) ] [ R.string "Toggle" ]
      ]
end

let main = R.div [] [ Portal.make () ]

let () =
  match R.find "main" with
  | Some element -> R.render main element
  | None -> Js.Console.error "<main> not found!"
