(*
module type T = sig
  type g1

  type g2

  type g3

  val miller_loop_simple : g1 -> g2 -> g3
end

module Make
    (G1 : Elliptic_curve_sig.T)
    (G2 : Elliptic_curve_sig.T)
    (G3 : Elliptic_curve_sig.T) :
  T with type g1 = G1.t and type g2 = G2.t and type g3 = G3.t = struct
  type g1 = G1.t

  type g2 = G2.t

  type g3 = G3.t

  let miller_loop_simple _g1 _g2 = G3.random ()
end
*)

(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_pairing_miller_loop_simple :
  Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing_miller_loop_simple"
  [@@noalloc]

(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_pairing : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing"
  [@@noalloc]

let miller_loop_simple (g1 : G1.t) (g2 : G2.t) : Fq12.t =
  (* FIXME/IMPROVEME: Use a method create_buffer? *)
  let buffer = Fq12.zero () in
  ml_bls12_381_pairing_miller_loop_simple
    (Fq12.to_bytes buffer)
    (G1.to_bytes g1)
    (G2.to_bytes g2) ;
  buffer

let pairing (g1 : G1.t) (g2 : G2.t) : Fq12.t =
  (* FIXME/IMPROVEME: Use a method create_buffer? *)
  let buffer = Fq12.zero () in
  ml_bls12_381_pairing (Fq12.to_bytes buffer) (G1.to_bytes g1) (G2.to_bytes g2) ;
  buffer
