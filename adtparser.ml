type op = Add | Mul
type expr =
  | Int of int
  | Binop of op * expr * expr

let rec eval = function
  | Int n -> n
  | Binop (Add, a, b) -> eval a + eval b
(*  | Binop (Mul, a, b) -> eval a * eval b *)
