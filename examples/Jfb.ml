module R = Reaml

let adjectives = [| "pretty"; "large"; "big"; "small"; "tall"; "short"; "long";
"handsome"; "plain"; "quaint"; "clean"; "elegant"; "easy"; "angry"; "crazy";
"helpful"; "mushy"; "odd"; "unsightly"; "adorable"; "important" ; "inexpensive";
"cheap"; "expensive"; "fancy" |] [@@ocamlformat "disable"]

let colors = [| "red"; "yellow"; "blue"; "green"; "pink"; "brown"; "purple" ;
"brown"; "white"; "black"; "orange" |] [@@ocamlformat "disable"]

let nouns = [| "table"; "chair"; "house"; "bbq"; "desk"; "car"; "pony";
"cookie"; "sandwich"; "burger"; "pizza"; "mouse"; "keyboard" |] [@@ocamlformat
"disable"]

let sample array =
  Js.Array.unsafe_get array (Js.Math.random_int 0 (Js.Array.length array))

module Store = struct
  type row =
    { id : int
    ; label : string
    }

  type state =
    { data : row array
    ; selected : int option
    }

  type action =
    | Run
    | RunLots
    | Add
    | Update
    | Clear
    | SwapRows
    | Select of int
    | Remove of int

  let nextId = ref 1

  let makeRow () =
    let id = !nextId in
    nextId := id + 1;
    { id; label = sample adjectives ^ " " ^ sample colors ^ " " ^ sample nouns }

  let makeRows count = Belt.Array.range 1 count |. Belt.Array.map (fun _ -> makeRow ())

  let reducer state = function
    | Run -> { data = makeRows 1000; selected = None }
    | RunLots -> { data = makeRows 10000; selected = None }
    | Add -> { state with data = Belt.Array.concat state.data (makeRows 1000) }
    | Update ->
      { state with
        data =
          Belt.Array.mapWithIndex state.data (fun index row ->
              if index mod 10 = 0 then { row with label = row.label ^ " !!!" } else row)
      }
    | Clear -> { data = [||]; selected = None }
    | SwapRows ->
      let a, b = 1, 998 in
      let data =
        match Belt.Array.get state.data a, Belt.Array.get state.data b with
        | Some aa, Some bb ->
          Belt.Array.mapWithIndex state.data (fun index row ->
              if index = a then bb else if index = b then aa else row)
        | _ -> state.data
      in
      { state with data }
    | Remove id ->
      let data = Belt.Array.keep state.data (fun row -> row.id <> id) in
      { state with data }
    | Select id -> { state with selected = Some id }

  let use =
   fun [@reaml.hook] () ->
    let[@reaml] state, dispatch = R.useReducer reducer { data = [||]; selected = None } in
    state, dispatch
end

module Row = struct
  type props =
    { key : int
    ; row : Store.row
    ; selected : bool
    ; dispatch : Store.action -> unit
    }

  let make =
   fun [@reaml.component.memo "Row"] { row; selected; dispatch } ->
    let onSelect _ = dispatch (Select row.id) in
    let onRemove _ = dispatch (Remove row.id) in
    R.tr
      (if selected then [ R.class_ "danger" ] else [])
      [ R.td [ R.class_ "col-md-1" ] [ R.int row.id ]
      ; R.td [ R.class_ "col-md-4" ] [ R.a [ R.onClick onSelect ] [ R.string row.label ] ]
      ; R.td
          [ R.class_ "col-md-1" ]
          [ R.a
              [ R.onClick onRemove ]
              [ R.span
                  [ R.class_ "glyphicon glyphicon-remove"; R.aria "hidden" "true" ]
                  []
              ]
          ]
      ; R.td [ R.class_ "col-md-6" ] []
      ]
end

module Button = struct
  type props =
    { id : string
    ; onClick : unit -> unit
    ; title : string
    }

  let make =
   fun [@reaml.component "Button"] { id; onClick; title } ->
    R.div
      [ R.class_ "col-sm-6 smallpad" ]
      [ R.button
          [ R.type_ "button"
          ; R.class_ "btn btn-primary btn-block"
          ; R.id id
          ; R.onClick (fun _ -> onClick ())
          ]
          [ R.string title ]
      ]
end

let jumbotron (dispatch : Store.action -> unit) =
  R.div
    [ R.class_ "jumbotron" ]
    [ R.div
        [ R.class_ "row" ]
        [ R.div [ R.class_ "col-md-6" ] [ R.h1 [] [ R.string "Reaml Keyed" ] ]
        ; R.div
            [ R.class_ "col-md-6" ]
            [ R.div
                [ R.class_ "row" ]
                [ Button.make
                    { id = "run"
                    ; title = "Create 1,000 rows"
                    ; onClick = (fun () -> dispatch Run)
                    }
                ; Button.make
                    { id = "runlots"
                    ; title = "Create 10,000 rows"
                    ; onClick = (fun () -> dispatch RunLots)
                    }
                ; Button.make
                    { id = "add"
                    ; title = "Append 1,000 rows"
                    ; onClick = (fun () -> dispatch Add)
                    }
                ; Button.make
                    { id = "update"
                    ; title = "Update every 10th row"
                    ; onClick = (fun () -> dispatch Update)
                    }
                ; Button.make
                    { id = "clear"
                    ; title = "Clear"
                    ; onClick = (fun () -> dispatch Clear)
                    }
                ; Button.make
                    { id = "swaprows"
                    ; title = "Swap Rows"
                    ; onClick = (fun () -> dispatch SwapRows)
                    }
                ]
            ]
        ]
    ]

module Main = struct
  let make =
   fun [@reaml.component "Main"] () ->
    let[@reaml] state, dispatch = Store.use () in
    R.div
      [ R.class_ "container" ]
      [ jumbotron dispatch
      ; R.table
          [ R.class_ "table table-hover table-striped test-data" ]
          [ R.tbody
              []
              [ Belt.Array.map state.data (fun (row : Store.row) ->
                    Row.make
                      { key = row.id
                      ; row
                      ; selected = state.selected = Some row.id
                      ; dispatch
                      })
                |> R.array
              ]
          ]
      ; R.span
          [ R.class_ "preloadicon glyphicon glyphicon-remove"; R.aria "hidden" "true" ]
          []
      ]
end

let () = Main.make () |> R.renderTo "main"
