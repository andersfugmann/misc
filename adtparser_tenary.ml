type op = Add | Le
type value = Int of int | Bool of bool
type expr =
  | Value of value
  | Binop of op * expr * expr
  | Cond of expr * expr * expr

let rec eval = function
  | Value v -> v
  | Binop (Add, a, b) ->
      let (Int a, Int b) = (eval a, eval b) in
      Int (a + b)
  | Binop (Le, a, b) ->
      let (Int a, Int b) = (eval a, eval b) in
      Bool (a < b)
  | Cond (pred, a, b) ->
      let Bool p = eval pred in
      if p then eval a else eval b
