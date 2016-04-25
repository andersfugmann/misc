let rec eval = function
  | `Int n -> n
  | `Binop (`Plus, a, b) -> eval a + eval b
  | `Binop (`Mult, a, b) -> eval a * eval b

let to_string n =
  string_of_int n

let () =
  let expr = `Binop(`Plus, `Int 1, `Binop(`Plus, `Int 1, `Int 5)) in
  Printf.printf "%s\n" (to_string (eval expr))
