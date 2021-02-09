type _ binop =
  | Add: int binop
  | Lt: bool binop

type _ expr =
  | Int: int -> int expr
  | Bool: bool -> bool expr
  | Binop: (int binop * int expr * int expr) -> int expr
  | Cond: (bool expr * 'a expr * 'a expr) -> 'a expr

let rec eval: type a. a expr -> a = function
  | Int a -> a
  | Bool b -> b
  | Binop (Add, a, b) -> eval a + eval b
  | Binop (Lt,  a, b) -> eval a < eval b
  | Cond (pred, a, b) -> if eval pred then eval a else eval b
