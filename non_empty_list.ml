type non_empty
type empty
type (_, _) t =
  | (::) : 'elt * ('elt, _) t -> ('elt, non_empty) t
  | [] : (_, empty) t

let hd = function x :: _ -> x
let rec fold_left ~init ~f = function
  | x :: [] -> f init x
  | x1 :: x2 :: xs -> fold_left ~init:(f init x1) ~f (x2 :: xs)
let reduce ~f = function
  | x :: [] -> x
  | x1 :: x2 :: xs -> fold_left ~init:x1 ~f (x2 :: xs)

let sum = reduce ~f:(+) [4;5;6] (* 15 *)

let sum = reduce ~f:(+) []
(* Error: This expression has type (int, empty) t
   but an expression was expected of type (int, non_empty) t *)
