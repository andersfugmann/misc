let rec eval = function
  | `Int n -> `Int n
  | `Bool n -> `Bool n
  | `Binop (`Plus, a, b) ->
      begin
        match (eval a, eval b) with
        | `Int a, `Int b -> `Int (a + b)
        | _ -> failwith "Cannot add booleans"
      end
  | `Binop (`Mult, a, b) ->
      begin
        match (eval a, eval b) with
        | `Int a, `Int b -> `Int (a * b)
        | _ -> failwith "Cannot multiply booleans"
      end
  | `Binop (`Less, a, b) ->
      begin
        match (eval a, eval b) with
        | `Int a, `Int b -> `Bool (a < b)
        | _ -> failwith "Cannot multiply booleans"
      end

  | `Test(pred, a, b) ->
      begin
        match eval pred with
        | `Bool true -> eval a
        | `Bool false -> eval b
        | `Int _ -> failwith "Cannot test an integer"
      end

let to_string = function
  | `Bool true -> "True"
  | `Bool false -> "False"
  | `Int n -> string_of_int n

let () =
  let expr = `Binop(`Plus, `Int 1, `Binop(`Plus, `Int 1, `Int 5)) in
  let expr = `Binop(`Plus, `Int 1, 5)) in
  Printf.printf "%s\n" (to_string (eval expr))
