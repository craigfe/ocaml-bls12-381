(** General module signature for a finite field *)
module type T = sig
  type t
  (* Let's use a function for the moment *)
  val zero : unit -> t
  val one : unit -> t
  val is_zero : t -> bool
  val is_one : t -> bool
  val random : unit -> t
  val add : t -> t -> t
  val mul : t -> t -> t
  val eq : t -> t -> bool
end
