include Ff_sig.T

val order : Z.t

val of_z : Z.t -> t

val to_z : t -> Z.t

(** Returns the decimal representation as a string *)
val to_string : t -> String.t

(** Constructor from the decimal representation of the element
    Undefined behaviours if the given element is not in the field or any other
    representation than decimal is used. Use this function carefully.
 *)
val of_string : String.t -> t
