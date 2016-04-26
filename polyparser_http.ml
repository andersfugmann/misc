open Lwt
open Cohttp
open Cohttp_lwt_unix

open MParser
let infix p op =
  Infix (p |>> (fun _ a b -> (`Binop (op, a, b))), Assoc_left)

let operators =
  [ [ infix (char '*') `Mul; ];
    [ infix (char '+') `Add; ]; ]

let decimal =
  many1_chars digit |>> int_of_string

let expr =
  expression operators (decimal |>> fun i -> `Int i)

let parse_expression s =
  match MParser.parse_string expr s () with
  | Success e ->
    e
  | Failed (msg, _e) ->
    failwith msg


let rec eval = function
  | `Int n -> n
  | `Binop (`Add, a, b) -> eval a + eval b
  | `Binop (`Mul, a, b) -> eval a * eval b

let server =
  let callback _conn req _body =
    let path = req |> Request.uri |> Uri.path in
    let expr = String.sub path 1 (String.length path-1) in
    let res =
      parse_expression expr |> eval |> string_of_int
    in
    Server.respond_string ~status:`OK ~body:res ()
  in
  Server.create ~mode:(`TCP (`Port 8000)) (Server.make ~callback ())

let () = ignore (Lwt_main.run server)
