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

let miller_loop (xs : (G1.Uncompressed.t * G2.Uncompressed.t) list) : Fq12.t =
  let rec f acc xs =
    let buffer = Fq12.empty () in
    match xs with
    | [] -> acc
    | [(g1, g2)] -> Fq12.mul (miller_loop_simple g1 g2) acc
    | [(g1_1, g2_1); (g1_2, g2_2)] ->
        ml_bls12_381_pairing_miller_loop_2
          (Fq12.to_bytes buffer)
          (G1.Uncompressed.to_bytes g1_1)
          (G1.Uncompressed.to_bytes g1_2)
          (G2.Uncompressed.to_bytes g2_1)
          (G2.Uncompressed.to_bytes g2_2) ;
        Fq12.mul buffer acc
    | [(g1_1, g2_1); (g1_2, g2_2); (g1_3, g2_3)] ->
        ml_bls12_381_pairing_miller_loop_3
          (Fq12.to_bytes buffer)
          (G1.Uncompressed.to_bytes g1_1)
          (G1.Uncompressed.to_bytes g1_2)
          (G1.Uncompressed.to_bytes g1_3)
          (G2.Uncompressed.to_bytes g2_1)
          (G2.Uncompressed.to_bytes g2_2)
          (G2.Uncompressed.to_bytes g2_3) ;
        Fq12.mul buffer acc
    | [(g1_1, g2_1); (g1_2, g2_2); (g1_3, g2_3); (g1_4, g2_4)] ->
        ml_bls12_381_pairing_miller_loop_4
          (Fq12.to_bytes buffer)
          (G1.Uncompressed.to_bytes g1_1)
          (G1.Uncompressed.to_bytes g1_2)
          (G1.Uncompressed.to_bytes g1_3)
          (G1.Uncompressed.to_bytes g1_4)
          (G2.Uncompressed.to_bytes g2_1)
          (G2.Uncompressed.to_bytes g2_2)
          (G2.Uncompressed.to_bytes g2_3)
          (G2.Uncompressed.to_bytes g2_4) ;
        Fq12.mul buffer acc
    | [(g1_1, g2_1); (g1_2, g2_2); (g1_3, g2_3); (g1_4, g2_4); (g1_5, g2_5)] ->
        ml_bls12_381_pairing_miller_loop_5
          (Fq12.to_bytes buffer)
          (G1.Uncompressed.to_bytes g1_1)
          (G1.Uncompressed.to_bytes g1_2)
          (G1.Uncompressed.to_bytes g1_3)
          (G1.Uncompressed.to_bytes g1_4)
          (G1.Uncompressed.to_bytes g1_5)
          (G2.Uncompressed.to_bytes g2_1)
          (G2.Uncompressed.to_bytes g2_2)
          (G2.Uncompressed.to_bytes g2_3)
          (G2.Uncompressed.to_bytes g2_4)
          (G2.Uncompressed.to_bytes g2_5) ;
        Fq12.mul buffer acc
    | (g1_1, g2_1)
      :: (g1_2, g2_2)
         :: (g1_3, g2_3) :: (g1_4, g2_4) :: (g1_5, g2_5) :: (g1_6, g2_6) :: xs
      ->
        ml_bls12_381_pairing_miller_loop_6
          (Fq12.to_bytes buffer)
          (G1.Uncompressed.to_bytes g1_1)
          (G1.Uncompressed.to_bytes g1_2)
          (G1.Uncompressed.to_bytes g1_3)
          (G1.Uncompressed.to_bytes g1_4)
          (G1.Uncompressed.to_bytes g1_5)
          (G1.Uncompressed.to_bytes g1_6)
          (G2.Uncompressed.to_bytes g2_1)
          (G2.Uncompressed.to_bytes g2_2)
          (G2.Uncompressed.to_bytes g2_3)
          (G2.Uncompressed.to_bytes g2_4)
          (G2.Uncompressed.to_bytes g2_5)
          (G2.Uncompressed.to_bytes g2_6) ;
        let acc = Fq12.mul buffer acc in
        f acc xs
  in
  if List.length xs = 0 then failwith "Empty list of points given"
  else unsafe_final_exponentiation (f (Fq12.one ()) xs)
