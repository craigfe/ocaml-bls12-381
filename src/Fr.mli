include Ff_sig.T

val to_z : t -> Z.t

(** Returns the decimal representation as a string *)
val to_string : t -> String.t

(** Constructors from the decimal representation of the element *)
val of_string : String.t -> t
