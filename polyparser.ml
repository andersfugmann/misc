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

let parse s =
  match MParser.parse_string expr s () with
  | Success e ->
    e
  | Failed (msg, _e) ->
    failwith msg

let rec eval = function
  | `Int n -> n
  | `Binop (`Add, a, b) -> eval a + eval b
  | `Binop (`Mul, a, b) -> eval a * eval b

let () =
  (* Read an expression from stdin *)
  let expr = parse (Sys.argv.(1)) in
    Printf.printf "%d\n" (eval expr)
