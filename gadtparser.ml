type _ binop =
  | Add: int binop
  | Mul: int binop
  | Lt: bool binop

type _ expr =
  | Int: int -> int expr
  | Bool: bool -> bool expr
  | Binop: ('a binop * int expr * int expr) -> 'a expr
  | Cond: (bool expr * 'a expr * 'a expr) -> 'a expr

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
    match eval pred with
    | true -> eval a
    | false -> eval b

let () =
  let expr =
    Binop (Add, Int 5,
           (Cond (Binop (Lt, Int 4, Int 2), Int 5, Int 9)))
  in
  eval expr |> string_of_int |> print_endline
