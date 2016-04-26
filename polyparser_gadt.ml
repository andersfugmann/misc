type _ binop =
  | Add: int binop
  | Mul: int binop
  | Lt: bool binop

type _ expr =
  | Int: int -> int expr
  | Bool: bool -> bool expr
  | Binop: ('a binop * int expr * int expr) -> 'a expr
  | Cond: (bool expr * 'a expr * 'a expr) -> 'a expr


open MParser
let infix : type a. 'b -> a binop -> 'c = fun p -> function
  | Add -> Infix (p |>> (fun _ a b -> (Binop (Add, a, b))), Assoc_left)
  | Mul -> Infix (p |>> (fun _ a b -> (Binop (Mul, a, b))), Assoc_left)
  | Lt ->  Infix (p |>> (fun _ a b -> (Binop (Lt, a, b))), Assoc_left)

let operators =
  [ [ infix (char '*') Mul; ];
    [ infix (char '+') Add; ];
    (*     [ infix (char '<') Lt; ]; *)
  ]

let decimal =
  many1_chars digit |>> int_of_string

let expr =
  expression operators (decimal |>> fun i -> Int i)

let parse s =
  match MParser.parse_string expr s () with
  | Success e ->
    e
  | Failed (msg, _e) ->
    failwith msg


let rec eval: type a. a expr -> a = function
  | Int a -> a
  | Bool b -> b
  | Binop (Add, a, b) ->
    eval a + eval b
  | Binop (Mul, a, b) ->
    eval a * eval b
  | Binop (Lt, a, b) ->
    eval a < eval b
  | Cond (pred, a, b) ->
    if eval pred then
      eval a
    else
      eval b

let () =
  let expr = Binop (Add, Int 5,
                   (Cond (Binop (Lt, Int 4, Int 2), Int 5, Int 9))) in
  Printf.printf "%d\n" (eval expr)
