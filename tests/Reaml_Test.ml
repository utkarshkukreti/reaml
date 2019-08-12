open Jest
open Expect

let () =
  describe "Reaml" (fun () -> test "1 + 2 == 3" (fun () -> expect (1 + 2) |> toBe 3))
