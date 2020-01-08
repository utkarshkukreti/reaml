module R = Reaml;

let main = R.h1([R.id("hello")], [R.string("Hello, world!")]);

main |> R.renderTo("main");
