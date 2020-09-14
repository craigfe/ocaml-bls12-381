module type RAW_BASE = sig
  val check_bytes : Bytes.t -> bool

  val is_zero : Bytes.t -> bool

  val is_one : Bytes.t -> bool

  val random : Bytes.t -> unit

  val zero : Bytes.t -> unit

  val one : Bytes.t -> unit

  val add : Bytes.t -> Bytes.t -> Bytes.t -> unit

  val mul : Bytes.t -> Bytes.t -> Bytes.t -> unit

  val unsafe_inverse : Bytes.t -> Bytes.t -> unit

  val eq : Bytes.t -> Bytes.t -> bool

  val negate : Bytes.t -> Bytes.t -> unit

  val square : Bytes.t -> Bytes.t -> unit

  val double : Bytes.t -> Bytes.t -> unit

  val pow : Bytes.t -> Bytes.t -> Bytes.t -> unit
end
