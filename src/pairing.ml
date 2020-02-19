(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_pairing_miller_loop_simple :
  Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing_miller_loop_simple"
  [@@noalloc]

(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_pairing : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing"
  [@@noalloc]

external ml_bls12_381_unsafe_pairing_final_exponentiation :
  Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_unsafe_pairing_final_exponentiation"
  [@@noalloc]

let miller_loop_simple (g1 : G1.Uncompressed.t) (g2 : G2.Uncompressed.t) :
    Fq12.t =
  let buffer = Fq12.empty () in
  ml_bls12_381_pairing_miller_loop_simple
    (Fq12.to_bytes buffer)
    (G1.Uncompressed.to_bytes g1)
    (G2.Uncompressed.to_bytes g2) ;
  buffer

let pairing (g1 : G1.Uncompressed.t) (g2 : G2.Uncompressed.t) : Fq12.t =
  let buffer = Fq12.empty () in
  ml_bls12_381_pairing
    (Fq12.to_bytes buffer)
    (G1.Uncompressed.to_bytes g1)
    (G2.Uncompressed.to_bytes g2) ;
  buffer

let unsafe_final_exponentiation (e : Fq12.t) : Fq12.t =
  let buffer = Fq12.empty () in
  ml_bls12_381_unsafe_pairing_final_exponentiation
    (Fq12.to_bytes buffer)
    (Fq12.to_bytes e) ;
  buffer

let final_exponentiation (e : Fq12.t) : Fq12.t option =
  if Fq12.is_zero e then None
  else
    let buffer = Fq12.empty () in
    ml_bls12_381_unsafe_pairing_final_exponentiation
      (Fq12.to_bytes buffer)
      (Fq12.to_bytes e) ;
    Some buffer
