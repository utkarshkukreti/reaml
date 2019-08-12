open Jest
open Expect
module R = Reaml.Router

let () =
  describe "Reaml.Router" (fun () ->
      describe "Url" (fun () ->
          describe "fromString" (fun () ->
              let go string url =
                test
                  ("\"" ^ string ^ "\"")
                  (fun () -> expect (R.Url.fromString string) |> toEqual url)
              in
              go "" { R.Url.path = [] };
              go "foo" { R.Url.path = [ "foo" ] };
              go "//foo/" { R.Url.path = [ "foo" ] };
              go "//foo/bar//baz/" { R.Url.path = [ "foo"; "bar"; "baz" ] });
          describe "toString" (fun () ->
              let go mode url string =
                test
                  ("\"" ^ string ^ "\"")
                  (fun () -> expect (R.Url.toString mode url) |> toEqual string)
              in
              go R.History { R.Url.path = [] } "/";
              go R.History { R.Url.path = [ "foo" ] } "/foo";
              go R.History { R.Url.path = [ "foo"; "bar"; "baz" ] } "/foo/bar/baz";
              go R.Hash { R.Url.path = [] } "#/";
              go R.Hash { R.Url.path = [ "foo" ] } "#/foo";
              go R.Hash { R.Url.path = [ "foo"; "bar"; "baz" ] } "#/foo/bar/baz"));
      describe "Parser" (fun () ->
          describe "parse" (fun () ->
              let open R.Parser in
              let go string parser parsed =
                test
                  ("\"" ^ string ^ "\"")
                  (fun () ->
                    expect (R.Parser.parse parser (R.Url.fromString string))
                    |> toEqual parsed)
              in
              let t2 a b = a, b in
              let t3 a b c = a, b, c in
              go "" (root ()) (Some ());
              go "foo" (root ()) None;
              go "foo" (s "foo" |> map ()) (Some ());
              go "foo" string (Some "foo");
              let a = s "foo" </> s "bar" </> s "123" |> map () in
              let b = s "foo" </> string </> string |> map t2 in
              let c = s "foo" </> string </> int |> map t2 in
              let d = string </> s "bar" </> string |> map t2 in
              let e = string </> s "bar" </> int |> map t2 in
              let f = string </> string </> int |> map t3 in
              go "foo/bar/123" a (Some ());
              go "foo/bar/123" b (Some ("bar", "123"));
              go "foo/bar/123" c (Some ("bar", 123));
              go "foo/bar/123" d (Some ("foo", "123"));
              go "foo/bar/123" e (Some ("foo", 123));
              go "foo/bar/123" f (Some ("foo", "bar", 123));
              go "foo/bar/baz" a None;
              go "foo/bar/baz" b (Some ("bar", "baz"));
              go "foo/bar/baz" c None;
              go "foo/bar/baz" d (Some ("foo", "baz"));
              go "foo/bar/baz" e None;
              go "foo/bar/baz" f None;
              let a = oneOf [ s "foo" |> map 0; int ] in
              go "foo" a (Some 0);
              go "123" a (Some 123);
              go "baz" a None));
      describe "Builder" (fun () ->
          let open R.Builder in
          test "[]" (fun () -> expect root |> toEqual { R.Url.path = [] });
          test "[]" (fun () ->
              expect (root </> "foo") |> toEqual { R.Url.path = [ "foo" ] });
          test "[]" (fun () ->
              expect (root </> "foo" </> int 123)
              |> toEqual { R.Url.path = [ "foo"; "123" ] }));
      describe "Make" (fun () ->
          let module Router = struct
            type t =
              | Home
              | Posts
              | Post of int

            include R.Make (struct
              type nonrec t = t

              let mode = R.History

              (* We are not testing this. *)
              let parse _ = None

              let build =
                R.Builder.(
                  function
                  | Home -> root
                  | Posts -> root </> "posts"
                  | Post id -> root </> "posts" </> int id)
            end)
          end
          in
          test "Home" (fun () ->
              expect (Router.link Router.Home [] [])
              |> toEqual (Reaml.a [ Reaml.href "/" ] []));
          test "Posts" (fun () ->
              expect (Router.link Router.Posts [] [])
              |> toEqual (Reaml.a [ Reaml.href "/posts" ] []));
          test "Post 123" (fun () ->
              expect (Router.link (Router.Post 123) [] [])
              |> toEqual (Reaml.a [ Reaml.href "/posts/123" ] []))))
