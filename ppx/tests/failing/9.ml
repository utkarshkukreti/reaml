type foo = {
  key : int;
  name : string;
}

let foo = fun [@reaml.component "Foo"] { key; name } -> Obj.magic ()
