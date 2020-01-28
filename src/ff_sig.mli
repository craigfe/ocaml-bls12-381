(** General module signature for a finite field *)
module type T = sig
  type t
  (* Let's use a function for the moment *)
  val zero : unit -> t
  val is_zero : t -> bool
  val random : unit -> t
  (* val is_one : t -> bool *)
  (* val zero : unit -> t *)
end
