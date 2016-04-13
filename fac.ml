let rec fac = function
  | 0 -> 1
  | n -> n * fac (n - 1)
