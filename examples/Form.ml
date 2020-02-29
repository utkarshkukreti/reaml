module R = Reaml

module Form = struct
  let[@reaml.component "Form"] make () =
    let[@reaml] name, setName = R.useState "" in
    let[@reaml] agreeToTerms, setAgreeToTerms = R.useState false in
    let isValid = name <> "" && agreeToTerms in
    R.div []
      [
        R.div []
          [
            R.span [] [ R.string "Name: " ];
            R.input [ R.value name; R.onInputValue setName ] [];
          ];
        R.div []
          [
            R.span [] [ R.string "Agree To Terms?: " ];
            R.input
              [
                R.type_ "checkbox";
                R.checked agreeToTerms;
                R.onInputChecked setAgreeToTerms;
              ]
              [];
          ];
        R.button [ R.disabled (not isValid) ] [ R.string "Submit" ];
        R.pre []
          [
            Js.Json.(
              [ "name", string name; "agreeToTerms", boolean agreeToTerms ]
              |> Js.Dict.fromList
              |> object_
              |. stringifyWithSpace 2
              |> R.string);
          ];
      ]
end

let main = Form.make ()
let () = main |> R.renderTo "main"
