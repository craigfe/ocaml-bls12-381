(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_fq_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_fq_is_zero"
  [@@noalloc]

external ml_bls12_381_fq_is_one : Bytes.t -> bool
  = "ml_librustc_bls12_381_fq_is_one"
  [@@noalloc]

external ml_bls12_381_fq_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_zero"
  [@@noalloc]

external ml_bls12_381_fq_one : Bytes.t -> unit = "ml_librustc_bls12_381_fq_one"
  [@@noalloc]

external ml_bls12_381_fq_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_random"
  [@@noalloc]

external ml_bls12_381_fq_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_add"
  [@@noalloc]

external ml_bls12_381_fq_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_mul"
  [@@noalloc]

external ml_bls12_381_fq_unsafe_inverse : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_unsafe_inverse"
  [@@noalloc]

external ml_bls12_381_fq_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_negate"
  [@@noalloc]

external ml_bls12_381_fq_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_fq_eq"
  [@@noalloc]

(** High level (OCaml) definitions/logic *)
let fq_size_bytes = 48

type t = Bytes.t

let to_t (g : Bytes.t) : t = g

let is_zero g =
  assert (Bytes.length g = fq_size_bytes) ;
  ml_bls12_381_fq_is_zero g

let is_one g =
  assert (Bytes.length g = fq_size_bytes) ;
  ml_bls12_381_fq_is_one g

let zero () =
  let g = Bytes.create fq_size_bytes in
  ml_bls12_381_fq_zero g ;
  to_t g

let one () =
  let g = Bytes.create fq_size_bytes in
  ml_bls12_381_fq_one g ;
  to_t g

let random () =
  let g = Bytes.create fq_size_bytes in
  ml_bls12_381_fq_random g ;
  to_t g

let add x y =
  let g = Bytes.create fq_size_bytes in
  assert (Bytes.length x = fq_size_bytes) ;
  assert (Bytes.length y = fq_size_bytes) ;
  ml_bls12_381_fq_add g x y ;
  to_t g

let mul x y =
  let g = Bytes.create fq_size_bytes in
  assert (Bytes.length x = fq_size_bytes) ;
  assert (Bytes.length y = fq_size_bytes) ;
  ml_bls12_381_fq_mul g x y ;
  to_t g

let inverse g =
  let buffer = Bytes.create fq_size_bytes in
  ml_bls12_381_fq_unsafe_inverse buffer g ;
  to_t buffer

let inverse_opt g =
  if is_zero g then None
  else
    let buffer = Bytes.create fq_size_bytes in
    ml_bls12_381_fq_unsafe_inverse buffer g ;
    Some (to_t buffer)

let negate g =
  let buffer = Bytes.create fq_size_bytes in
  ml_bls12_381_fq_negate buffer g ;
  to_t buffer

let eq x y =
  (* IMPORTANT: DO NOT USE THE BYTES representation because we use 384 bits
     instead of 381 bits. We trust the binding offered by the library *)
  ml_bls12_381_fq_eq x y
