type _ binop =
  | Plus: int binop
  | Mult: int binop
  | Less: bool binop

type _ expr =
  | Expr: ('a binop * int expr * int expr) -> 'a expr
  | Cond: (bool expr * 'a expr * 'a expr) -> 'a expr
  | Int: int -> int expr
  | Bool: bool -> bool expr

let rec eval: type a. a expr -> a = function
  | Int a -> a
  | Bool b -> b
  | Expr (Plus, a, b) ->
    eval a + eval b
  | Expr (Mult, a, b) ->
    eval a * eval b
  | Expr (Less, a, b) ->
    eval a < eval b
  | Cond (pred, a, b) ->
    if eval pred then
      eval a
    else
      eval b

let () =
  let expr = Expr (Plus, Int 5,
                   (Cond (Expr (Less, Int 4, Int 2), Int 5, Int 9))) in
  Printf.printf "%d\n" (eval expr)
