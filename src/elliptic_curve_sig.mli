module type T = sig
  (** The type of the element in the elliptic curve *)
  type t

  module Scalar : Ff_sig.T

  (** Build an element using a bytes representation. Use carefully *)

  (** Create an empty value to store an element of the curve. DO NOT USE THIS TO
      DO COMPUTATIONS WITH, UNDEFINED BEHAVIORS MAY HAPPEN *)
  val empty : unit -> t

  (** UNSAFE *)
  val of_bytes : Bytes.t -> t

  (** Return a representation in bytes. Use carefully *)
  val to_bytes : t -> Bytes.t

  (** Zero of the elliptic curve *)
  val zero : unit -> t

  (** A fixed generator of the elliptic curve *)
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
  val mul : t -> Scalar.t -> t
end
