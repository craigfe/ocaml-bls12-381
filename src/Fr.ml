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

external ml_bls12_381_fr_square : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_square"
  [@@noalloc]

external ml_bls12_381_fr_double : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_fr_double"
  [@@noalloc]

external ml_bls12_381_fr_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_fr_eq"
  [@@noalloc]

(** High level (OCaml) definitions/logic *)
let fr_size_bytes = 32

type t = Bytes.t

let empty () = Bytes.create fr_size_bytes

let of_bytes (g : Bytes.t) : t = g

let to_bytes g = g

let is_zero g =
  assert (Bytes.length g = fr_size_bytes) ;
  ml_bls12_381_fr_is_zero g

let is_one g =
  assert (Bytes.length g = fr_size_bytes) ;
  ml_bls12_381_fr_is_one g

let zero () =
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_zero g ;
  of_bytes g

let one () =
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_one g ;
  of_bytes g

let random () =
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_random g ;
  of_bytes g

let add x y =
  assert (Bytes.length x = fr_size_bytes) ;
  assert (Bytes.length y = fr_size_bytes) ;
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_add g x y ;
  of_bytes g

let mul x y =
  assert (Bytes.length x = fr_size_bytes) ;
  assert (Bytes.length y = fr_size_bytes) ;
  let g = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_mul g x y ;
  of_bytes g

let inverse g =
  assert (Bytes.length g = fr_size_bytes) ;
  let buffer = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_unsafe_inverse buffer g ;
  of_bytes buffer

let inverse_opt g =
  assert (Bytes.length g = fr_size_bytes) ;
  if is_zero g then None
  else
    let buffer = Bytes.create fr_size_bytes in
    ml_bls12_381_fr_unsafe_inverse buffer g ;
    Some (of_bytes buffer)

let negate g =
  assert (Bytes.length g = fr_size_bytes) ;
  let buffer = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_negate buffer g ;
  of_bytes buffer

let square g =
  assert (Bytes.length g = fr_size_bytes) ;
  let buffer = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_square buffer g ;
  of_bytes buffer

let double g =
  assert (Bytes.length g = fr_size_bytes) ;
  let buffer = Bytes.create fr_size_bytes in
  ml_bls12_381_fr_double buffer g ;
  of_bytes buffer

let eq x y =
  (* IMPORTANT: DO NOT USE THE BYTES representation because we use 384 bits
     instead of 381 bits. We trust the binding offered by the library *)
  ml_bls12_381_fr_eq x y

let to_string a = Z.to_string (Z.of_bits (Bytes.to_string a))

let to_z a = Z.of_bits (Bytes.to_string a)

let two_z = Z.succ Z.one

let rec pow g n =
  if Z.equal n Z.zero then one ()
  else if Z.equal n Z.one then g
  else
    let (a, r) = Z.div_rem n two_z in
    let acc = pow g a in
    let acc_square = mul acc acc in
    if Z.equal r Z.zero then acc_square else mul acc_square g

let of_string s =
  let g = empty () in
  let s = Bytes.of_string s in
  Bytes.blit s 0 g 0 fr_size_bytes ;
  of_bytes s

let of_z z =
  let z = Bytes.of_string (Z.to_bits z) in
  let x = empty () in
  Bytes.blit z 0 x 0 fr_size_bytes ;
  x
