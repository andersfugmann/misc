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


(* Assume we have a parse_expression, that can convert a string to an expression
*)
let rec eval = function
  | `Int n -> n
  | `Binop (`Add, a, b) -> eval a + eval b
  | `Binop (`Mul, a, b) -> eval a * eval b

let () =
  (* Read an expression from stdin *)
  let expr = parse_expression (Sys.argv.(1)) in
    print_endline (string_of_int (eval expr))
