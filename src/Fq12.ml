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

let empty () = Bytes.create length_fq12

let to_bytes s = s

let of_bytes g = g

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
  of_bytes buffer

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

let two_z = Z.succ Z.one

let rec pow g n =
  if Z.equal n Z.zero then one ()
  else if Z.equal n Z.one then g
  else
    let (a, r) = Z.div_rem n two_z in
    let acc = pow g a in
    let acc_square = mul acc acc in
    if Z.equal r Z.zero then acc_square else mul acc_square g

let unsafe_of_z x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 =
  let x0 = Bytes.of_string (Z.to_bits x0) in
  let x1 = Bytes.of_string (Z.to_bits x1) in
  let x2 = Bytes.of_string (Z.to_bits x2) in
  let x3 = Bytes.of_string (Z.to_bits x3) in
  let x4 = Bytes.of_string (Z.to_bits x4) in
  let x5 = Bytes.of_string (Z.to_bits x5) in
  let x6 = Bytes.of_string (Z.to_bits x6) in
  let x7 = Bytes.of_string (Z.to_bits x7) in
  let x8 = Bytes.of_string (Z.to_bits x8) in
  let x9 = Bytes.of_string (Z.to_bits x9) in
  let x10 = Bytes.of_string (Z.to_bits x10) in
  let x11 = Bytes.of_string (Z.to_bits x11) in
  let g = empty () in
  Bytes.blit x0 0 g 0 48 ;
  Bytes.blit x1 0 g 48 48 ;
  Bytes.blit x2 0 g 96 48 ;
  Bytes.blit x3 0 g 144 48 ;
  Bytes.blit x4 0 g 192 48 ;
  Bytes.blit x5 0 g 240 48 ;
  Bytes.blit x6 0 g 288 48 ;
  Bytes.blit x7 0 g 336 48 ;
  Bytes.blit x8 0 g 384 48 ;
  Bytes.blit x9 0 g 432 48 ;
  Bytes.blit x10 0 g 480 48 ;
  Bytes.blit x11 0 g 528 48 ;
  of_bytes g

let unsafe_of_string x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 =
  let x0 = Bytes.of_string (Z.to_bits (Z.of_string x0)) in
  let x1 = Bytes.of_string (Z.to_bits (Z.of_string x1)) in
  let x2 = Bytes.of_string (Z.to_bits (Z.of_string x2)) in
  let x3 = Bytes.of_string (Z.to_bits (Z.of_string x3)) in
  let x4 = Bytes.of_string (Z.to_bits (Z.of_string x4)) in
  let x5 = Bytes.of_string (Z.to_bits (Z.of_string x5)) in
  let x6 = Bytes.of_string (Z.to_bits (Z.of_string x6)) in
  let x7 = Bytes.of_string (Z.to_bits (Z.of_string x7)) in
  let x8 = Bytes.of_string (Z.to_bits (Z.of_string x8)) in
  let x9 = Bytes.of_string (Z.to_bits (Z.of_string x9)) in
  let x10 = Bytes.of_string (Z.to_bits (Z.of_string x10)) in
  let x11 = Bytes.of_string (Z.to_bits (Z.of_string x11)) in
  let g = empty () in
  Bytes.blit x0 0 g 0 48 ;
  Bytes.blit x1 0 g 48 48 ;
  Bytes.blit x2 0 g 96 48 ;
  Bytes.blit x3 0 g 144 48 ;
  Bytes.blit x4 0 g 192 48 ;
  Bytes.blit x5 0 g 240 48 ;
  Bytes.blit x6 0 g 288 48 ;
  Bytes.blit x7 0 g 336 48 ;
  Bytes.blit x8 0 g 384 48 ;
  Bytes.blit x9 0 g 432 48 ;
  Bytes.blit x10 0 g 480 48 ;
  Bytes.blit x11 0 g 528 48 ;
  of_bytes g
