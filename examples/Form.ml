module R = Reaml

module Form = struct
  let make =
   fun [@reaml.component "Form"] () ->
    let[@reaml] name, setName = R.useState "" in
    let[@reaml] agreeToTerms, setAgreeToTerms = R.useState false in
    let isValid = name <> "" && agreeToTerms in
    R.div
      []
      [ R.div
          []
          [ R.span [] [ R.string "Name: " ]
          ; R.input [ R.value name; R.onInputValue setName ] []
          ]
      ; R.div
          []
          [ R.span [] [ R.string "Agree To Terms?: " ]
          ; R.input
              [ R.type_ "checkbox"; R.checked agreeToTerms; R.onCheck setAgreeToTerms ]
              []
          ]
      ; R.button [ R.disabled (not isValid) ] [ R.string "Submit" ]
      ; R.pre
          []
          [ R.string
              ([%bs.obj { name; agreeToTerms }]
              |. Js.Json.stringifyAny
              |. Belt.Option.getWithDefault "")
          ]
      ]
end

let main = Form.make ()
let () = main |> R.renderTo "main"
