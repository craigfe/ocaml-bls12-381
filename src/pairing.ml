(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_pairing_miller_loop_simple :
  Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing_miller_loop_simple"
  [@@noalloc]

external ml_bls12_381_pairing_miller_loop_2 :
  Bytes.t -> Bytes.t -> Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing_miller_loop_2"
  [@@noalloc]

external ml_bls12_381_pairing_miller_loop_3 :
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  unit
  = "ml_librustc_bls12_381_pairing_miller_loop_3_bytecode" "ml_librustc_bls12_381_pairing_miller_loop_3_native"
  [@@noalloc]

external ml_bls12_381_pairing_miller_loop_4 :
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  unit
  = "ml_librustc_bls12_381_pairing_miller_loop_4_bytecode" "ml_librustc_bls12_381_pairing_miller_loop_4_native"
  [@@noalloc]

external ml_bls12_381_pairing_miller_loop_5 :
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  unit
  = "ml_librustc_bls12_381_pairing_miller_loop_5_bytecode" "ml_librustc_bls12_381_pairing_miller_loop_5_native"
  [@@noalloc]

external ml_bls12_381_pairing_miller_loop_6 :
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  Bytes.t ->
  unit
  = "ml_librustc_bls12_381_pairing_miller_loop_6_bytecode" "ml_librustc_bls12_381_pairing_miller_loop_6_native"
  [@@noalloc]

(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_pairing : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_pairing"
  [@@noalloc]

external ml_bls12_381_unsafe_pairing_final_exponentiation :
  Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_unsafe_pairing_final_exponentiation"
  [@@noalloc]

(* The pairing goes in a finite field, not a group. We strengthen the signature *)
module Make
    (G1 : Elliptic_curve_sig.T)
    (G2 : Elliptic_curve_sig.T)
    (GT : Ff_sig.T) =
struct
  let miller_loop_simple (g1 : G1.t) (g2 : G2.t) : GT.t =
    let buffer = GT.empty () in
    ml_bls12_381_pairing_miller_loop_simple
      (GT.to_bytes buffer)
      (G1.to_bytes g1)
      (G2.to_bytes g2) ;
    buffer

  let pairing (g1 : G1.t) (g2 : G2.t) : GT.t =
    let buffer = GT.empty () in
    ml_bls12_381_pairing (GT.to_bytes buffer) (G1.to_bytes g1) (G2.to_bytes g2) ;
    buffer

  let unsafe_final_exponentiation (e : GT.t) : GT.t =
    let buffer = GT.empty () in
    ml_bls12_381_unsafe_pairing_final_exponentiation
      (GT.to_bytes buffer)
      (GT.to_bytes e) ;
    buffer

  let final_exponentiation (e : GT.t) : GT.t option =
    if GT.is_zero e then None
    else
      let buffer = GT.empty () in
      ml_bls12_381_unsafe_pairing_final_exponentiation
        (GT.to_bytes buffer)
        (GT.to_bytes e) ;
      Some buffer

  let miller_loop (xs : (G1.t * G2.t) list) : GT.t =
    let rec f acc xs =
      let buffer = GT.empty () in
      match xs with
      | [] ->
          acc
      | [(g1, g2)] ->
          GT.mul (miller_loop_simple g1 g2) acc
      | [(g1_1, g2_1); (g1_2, g2_2)] ->
          ml_bls12_381_pairing_miller_loop_2
            (GT.to_bytes buffer)
            (G1.to_bytes g1_1)
            (G1.to_bytes g1_2)
            (G2.to_bytes g2_1)
            (G2.to_bytes g2_2) ;
          GT.mul buffer acc
      | [(g1_1, g2_1); (g1_2, g2_2); (g1_3, g2_3)] ->
          ml_bls12_381_pairing_miller_loop_3
            (GT.to_bytes buffer)
            (G1.to_bytes g1_1)
            (G1.to_bytes g1_2)
            (G1.to_bytes g1_3)
            (G2.to_bytes g2_1)
            (G2.to_bytes g2_2)
            (G2.to_bytes g2_3) ;
          GT.mul buffer acc
      | [(g1_1, g2_1); (g1_2, g2_2); (g1_3, g2_3); (g1_4, g2_4)] ->
          ml_bls12_381_pairing_miller_loop_4
            (GT.to_bytes buffer)
            (G1.to_bytes g1_1)
            (G1.to_bytes g1_2)
            (G1.to_bytes g1_3)
            (G1.to_bytes g1_4)
            (G2.to_bytes g2_1)
            (G2.to_bytes g2_2)
            (G2.to_bytes g2_3)
            (G2.to_bytes g2_4) ;
          GT.mul buffer acc
      | [(g1_1, g2_1); (g1_2, g2_2); (g1_3, g2_3); (g1_4, g2_4); (g1_5, g2_5)]
        ->
          ml_bls12_381_pairing_miller_loop_5
            (GT.to_bytes buffer)
            (G1.to_bytes g1_1)
            (G1.to_bytes g1_2)
            (G1.to_bytes g1_3)
            (G1.to_bytes g1_4)
            (G1.to_bytes g1_5)
            (G2.to_bytes g2_1)
            (G2.to_bytes g2_2)
            (G2.to_bytes g2_3)
            (G2.to_bytes g2_4)
            (G2.to_bytes g2_5) ;
          GT.mul buffer acc
      | (g1_1, g2_1)
        :: (g1_2, g2_2)
           :: (g1_3, g2_3)
              :: (g1_4, g2_4) :: (g1_5, g2_5) :: (g1_6, g2_6) :: xs ->
          ml_bls12_381_pairing_miller_loop_6
            (GT.to_bytes buffer)
            (G1.to_bytes g1_1)
            (G1.to_bytes g1_2)
            (G1.to_bytes g1_3)
            (G1.to_bytes g1_4)
            (G1.to_bytes g1_5)
            (G1.to_bytes g1_6)
            (G2.to_bytes g2_1)
            (G2.to_bytes g2_2)
            (G2.to_bytes g2_3)
            (G2.to_bytes g2_4)
            (G2.to_bytes g2_5)
            (G2.to_bytes g2_6) ;
          let acc = GT.mul buffer acc in
          f acc xs
    in
    if List.length xs = 0 then failwith "Empty list of points given"
      (* it is fine to use unsafe because we should not have any nnull values,
         otherwise the pairing would be null everywhere *)
    else unsafe_final_exponentiation (f (GT.one ()) xs)
end

module Bls12_381 = Make (G1.Uncompressed) (G2.Uncompressed) (Fq12)
include Bls12_381
