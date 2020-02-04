external ml_bls12_381_fq12_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_fq12_is_zero"
  [@@noalloc]

external ml_bls12_381_fq12_is_one : Bytes.t -> bool
  = "ml_librustc_bls12_381_fq12_is_one"
  [@@noalloc]

external ml_bls12_381_fq12_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_random"
  [@@noalloc]

external ml_bls12_381_fq12_one : Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_one"
  [@@noalloc]

external ml_bls12_381_fq12_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_zero"
  [@@noalloc]

external ml_bls12_381_fq12_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_add"
  [@@noalloc]

external ml_bls12_381_fq12_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_mul"
  [@@noalloc]

external ml_bls12_381_fq12_unsafe_inverse : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_unsafe_inverse"
  [@@noalloc]

external ml_bls12_381_fq12_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_fq12_eq"
  [@@noalloc]

external ml_bls12_381_fq12_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_negate"
  [@@noalloc]

external ml_bls12_381_fq12_square : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_square"
  [@@noalloc]

external ml_bls12_381_fq12_double : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq12_double"
  [@@noalloc]

let length_fq12 = 576

(** 288 bytes long *)
type t = Bytes.t

let to_bytes s = s

let to_t g = g

let zero () =
  let g = Bytes.create length_fq12 in
  ml_bls12_381_fq12_zero g ;
  g

let one () =
  let g = Bytes.create length_fq12 in
  ml_bls12_381_fq12_one g ;
  g

let is_zero g = ml_bls12_381_fq12_is_zero g

let is_one g = ml_bls12_381_fq12_is_one g

let random () =
  let g = Bytes.create length_fq12 in
  ml_bls12_381_fq12_random g ;
  g

let add g1 g2 =
  assert (Bytes.length g1 = length_fq12) ;
  assert (Bytes.length g2 = length_fq12) ;
  let g = Bytes.create length_fq12 in
  ml_bls12_381_fq12_add g g1 g2 ;
  g

let mul g1 g2 =
  assert (Bytes.length g1 = length_fq12) ;
  assert (Bytes.length g2 = length_fq12) ;
  let g = Bytes.create length_fq12 in
  ml_bls12_381_fq12_mul g g1 g2 ;
  g

let eq g1 g2 =
  assert (Bytes.length g1 = length_fq12) ;
  assert (Bytes.length g2 = length_fq12) ;
  ml_bls12_381_fq12_eq g1 g2

let negate g =
  assert (Bytes.length g = length_fq12) ;
  let opposite_buffer = Bytes.create length_fq12 in
  ml_bls12_381_fq12_negate opposite_buffer g ;
  opposite_buffer

let square g =
  assert (Bytes.length g = length_fq12) ;
  let buffer = Bytes.create length_fq12 in
  ml_bls12_381_fq12_square buffer g ;
  buffer

let double g =
  assert (Bytes.length g = length_fq12) ;
  let buffer = Bytes.create length_fq12 in
  ml_bls12_381_fq12_double buffer g ;
  buffer

let inverse g =
  assert (Bytes.length g = length_fq12) ;
  let inverse_buffer = Bytes.create length_fq12 in
  ml_bls12_381_fq12_unsafe_inverse inverse_buffer g ;
  inverse_buffer

let inverse_opt g =
  if is_zero g then None
  else
    let inverse_buffer = Bytes.create length_fq12 in
    ml_bls12_381_fq12_unsafe_inverse inverse_buffer g ;
    Some inverse_buffer
