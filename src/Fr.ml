(** External definition, must use `Bytes.t` to represent the field elements *)
external ml_bls12_381_fr_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_fr_is_zero"
  [@@noalloc]

external ml_bls12_381_fr_is_one : Bytes.t -> bool
  = "ml_librustc_bls12_381_fr_is_one"
  [@@noalloc]

external ml_bls12_381_fr_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_zero"
  [@@noalloc]

external ml_bls12_381_fr_one : Bytes.t -> unit = "ml_librustc_bls12_381_fr_one"
  [@@noalloc]

external ml_bls12_381_fr_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_random"
  [@@noalloc]

external ml_bls12_381_fr_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_add"
  [@@noalloc]

external ml_bls12_381_fr_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_mul"
  [@@noalloc]

external ml_bls12_381_fr_unsafe_inverse : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_unsafe_inverse"
  [@@noalloc]

external ml_bls12_381_fr_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_negate"
  [@@noalloc]

external ml_bls12_381_fr_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_fr_eq"
  [@@noalloc]

(** High level (OCaml) definitions/logic *)
let fr_size_bytes = 32

type t = Bytes.t

let to_t (g : Bytes.t) : t = g

let is_zero g =
  assert (Bytes.length g = fr_size_bytes) ;
  ml_bls12_381_fr_is_zero g

let is_one g =
  assert (Bytes.length g = fr_size_bytes) ;
  ml_bls12_381_fr_is_one g

let zero () =
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_zero g ;
  to_t g

let one () =
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_one g ;
  to_t g

let random () =
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_random g ;
  to_t g

let add x y =
  let g = Bytes.create fr_size_bytes in
  assert (Bytes.length x = fr_size_bytes) ;
  assert (Bytes.length y = fr_size_bytes) ;
  ml_bls12_381_fr_add g x y ;
  to_t g

let mul x y =
  let g = Bytes.create fr_size_bytes in
  Printf.printf "Length of x: %d\n" (Bytes.length x);
  Printf.printf "Length of y: %d\n" (Bytes.length y);
  assert (Bytes.length x = fr_size_bytes) ;
  assert (Bytes.length y = fr_size_bytes) ;
  ml_bls12_381_fr_mul g x y ;
  to_t g

let inverse g =
  let buffer = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_unsafe_inverse buffer g ;
  to_t buffer

let inverse_opt g =
  if is_zero g then None
  else
    let buffer = Bytes.create fr_size_bytes in
    ml_bls12_381_fr_unsafe_inverse buffer g ;
    Some (to_t buffer)

let negate g =
  let buffer = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_negate buffer g ;
  to_t buffer

let eq x y =
  (* IMPORTANT: DO NOT USE THE BYTES representation because we use 384 bits
     instead of 381 bits. We trust the binding offered by the library *)
  ml_bls12_381_fr_eq x y
