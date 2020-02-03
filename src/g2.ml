external ml_bls12_381_g2_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_random"
  [@@noalloc]

external ml_bls12_381_g2_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_add"
  [@@noalloc]

external ml_bls12_381_g2_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_negate"
  [@@noalloc]

external ml_bls12_381_g2_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_g2_eq"
  [@@noalloc]

external ml_bls12_381_g2_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_g2_is_zero"
  [@@noalloc]

external ml_bls12_381_g2_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_mul"
  [@@noalloc]

external ml_bls12_381_g2_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_zero"
  [@@noalloc]

external ml_bls12_381_g2_one : Bytes.t -> unit = "ml_librustc_bls12_381_g2_one"
  [@@noalloc]

type t = Bytes.t

type scalar = Fr.t

let to_t (g : Bytes.t) : t = g

(* let to_bytes g = g *)

let zero () =
  let g = Bytes.create 192 in
  ml_bls12_381_g2_zero g ;
  to_t g

let one () =
  let g = Bytes.create 192 in
  ml_bls12_381_g2_one g ;
  to_t g

let random () =
  let g = Bytes.create 192 in
  ml_bls12_381_g2_random g ;
  to_t g

let add g1 g2 =
  assert (Bytes.length g1 = 192) ;
  assert (Bytes.length g2 = 192) ;
  let g = Bytes.create 192 in
  ml_bls12_381_g2_add g g2 g2 ;
  to_t g

let negate g =
  assert (Bytes.length g = 192) ;
  let buffer = Bytes.create 192 in
  ml_bls12_381_g2_negate buffer g ;
  to_t buffer

let eq g1 g2 =
  assert (Bytes.length g1 = 192) ;
  assert (Bytes.length g2 = 192) ;
  ml_bls12_381_g2_eq g1 g2

let is_zero g =
  assert (Bytes.length g = 192) ;
  ml_bls12_381_g2_is_zero g

let mul (g : t) (a : scalar) : t =
  assert (Bytes.length g = 192) ;
  assert (Bytes.length (Fr.to_bytes a) = 32) ;
  let buffer = Bytes.create 192 in
  ml_bls12_381_g2_mul buffer g (Fr.to_bytes a) ;
  to_t buffer
