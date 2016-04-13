let rec eval = function
  | `Number n -> n
  | `Binop (`Plus, a, b) -> eval a + eval b
  | `Binop (`Mult, a, b) -> eval a * eval b

let () =
  let expr = `Binop(`Plus, `Number 1, `Binop(`Plus, `Number 1, `Number 5)) in
  Printf.printf "%d\n" (eval expr)
