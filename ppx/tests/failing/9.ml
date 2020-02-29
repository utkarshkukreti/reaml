type foo = {
  key : int;
  name : string;
}

let[@reaml.component "Foo"] foo { key; name } = Obj.magic ()
