module type T = sig
  (** The type of the element in the elliptic curve *)
  type t

  (** The type of the scalars *)
  type scalar

  (** Build an element using a bytes representation. Use carefully *)
  (* val to_t : Bytes.t -> t *)

  (** Return a representation in bytes. Use carefully *)
  val to_bytes : t -> Bytes.t

  (** Zero of the elliptic curve *)
  val zero : unit -> t

  (** One of the elliptic curve *)
  val one : unit -> t

  (** Return true if the given element is zero *)
  val is_zero : t -> bool

  (** Generate a random element *)
  val random : unit -> t

  (** Return the addition of two element *)
  val add : t -> t -> t

  (** Return the opposite of the element *)
  val negate : t -> t

  (** Return true if the two elements are algebraically the same *)
  val eq : t -> t -> bool

  (** Multiply an element by a scalar *)
  val mul : t -> scalar -> t
end
