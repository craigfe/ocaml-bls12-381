module type T = sig
  type t

  type scalar

  val zero : unit -> t

  val one : unit -> t

  val is_zero : t -> bool

  val random : unit -> t

  val add : t -> t -> t

  val negate : t -> t

  val eq : t -> t -> bool

  val mul : t -> scalar -> t
end
