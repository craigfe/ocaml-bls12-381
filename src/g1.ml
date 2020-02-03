external ml_bls12_381_g1_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_random"
  [@@noalloc]

external ml_bls12_381_g1_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_add"
  [@@noalloc]

external ml_bls12_381_g1_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_negate"
  [@@noalloc]

external ml_bls12_381_g1_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_g1_eq"
  [@@noalloc]

external ml_bls12_381_g1_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_g1_is_zero"
  [@@noalloc]

external ml_bls12_381_g1_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_mul"
  [@@noalloc]

external ml_bls12_381_g1_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_zero"
  [@@noalloc]

external ml_bls12_381_g1_one : Bytes.t -> unit = "ml_librustc_bls12_381_g1_one"
  [@@noalloc]

type t = Bytes.t

type scalar = Fr.t

let to_t (g : Bytes.t) : t = g

(* let to_bytes g = g *)

let zero () =
  let g = Bytes.create 96 in
  ml_bls12_381_g1_zero g ;
  to_t g

let one () =
  let g = Bytes.create 96 in
  ml_bls12_381_g1_one g ;
  to_t g

let random () =
  let g = Bytes.create 96 in
  ml_bls12_381_g1_random g ;
  to_t g

let add g1 g2 =
  assert (Bytes.length g1 = 96) ;
  assert (Bytes.length g2 = 96) ;
  let g = Bytes.create 96 in
  ml_bls12_381_g1_add g g1 g2 ;
  to_t g

let negate g =
  assert (Bytes.length g = 96) ;
  let buffer = Bytes.create 96 in
  ml_bls12_381_g1_negate buffer g ;
  to_t buffer

let eq g1 g2 =
  assert (Bytes.length g1 = 96) ;
  assert (Bytes.length g2 = 96) ;
  ml_bls12_381_g1_eq g1 g2

let is_zero g =
  assert (Bytes.length g = 96) ;
  ml_bls12_381_g1_is_zero g

let mul (g : t) (a : scalar) : t =
  assert (Bytes.length g = 96) ;
  assert (Bytes.length (Fr.to_bytes a) = 32) ;
  let buffer = Bytes.create 96 in
  ml_bls12_381_g1_mul buffer g (Fr.to_bytes a) ;
  to_t buffer
