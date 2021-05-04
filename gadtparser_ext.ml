type (_, _) binop =
  | Add: (int, int) binop
  | Lt:  (int, bool) binop
  | And: (bool, bool) binop

type _ expr =
  | Int: int -> int expr
  | Bool:  bool -> bool expr
  | Binop: (('a, 'b) binop * 'a expr * 'a expr) -> 'b expr
  | Cond:  (bool expr * 'a expr * 'a expr) -> 'a expr

let rec eval: type a. a expr -> a = function
  | Int   a -> a
  | Bool  b -> b
  | Binop (Add, a, b)  -> eval a + eval b
  | Binop (Lt,  a, b)  -> eval a < eval b
  | Binop (And, a, b)  -> eval a && eval b
  | Cond  (pred, a, b) -> if eval pred then eval a else eval b
