(* 1 *)

let par = function x -> x mod 2 = 0;;

let rec pares = function
	  [] -> []
	| a :: resto -> if (par a) then a :: (pares resto)
								else (pares resto) ;;

let rec filter = function f -> function
		[] -> []
		| a :: resto -> if (f a) then a :: (filter f resto)
								else (filter f resto);;

(* 2 *)

let rec append = function 