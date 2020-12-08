exception FailToComputeFinalExponentiation of Fq12.t

val miller_loop : (G1.Uncompressed.t * G2.Uncompressed.t) list -> Fq12.t

(** Compute the miller loop on a single tuple of point *)
val miller_loop_simple : G1.Uncompressed.t -> G2.Uncompressed.t -> Fq12.t

(** Compute a pairing result of a list of points *)
val pairing : G1.Uncompressed.t -> G2.Uncompressed.t -> Fq12.t

(** Compute the final exponentiation of the given point. Returns a [None] if
      the point is null *)
val final_exponentiation_opt : Fq12.t -> Fq12.t option

(** Compute the final exponentiation of the given point. Raise
      [FailToComputeFinalExponentiation] if the point is null *)
val final_exponentiation_exn : Fq12.t -> Fq12.t
