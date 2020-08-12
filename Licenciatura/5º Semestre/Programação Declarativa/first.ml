(* 2017.12.05 *)

(* 1. *)
let apl1 a b = a b;;

let apl1 = function fff -> function aaa -> fff aaa;;

(* 2. *)
let apl2 f a = f ( f a );;

let rec apl = function 
	0 -> (function f -> function a -> a) |
	n -> (function f -> function a -> apl (n-1) f (f a));;



(*factorial recursivo *)
let rec fact = function
	0 -> 1 |
	x -> x * fact(x-1);;

(* 3. *)
