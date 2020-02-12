external ml_bls12_381_g2_compressed_of_uncompressed : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_of_uncompressed"
  [@@noalloc]

external ml_bls12_381_g2_uncompressed_of_compressed : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_uncompressed_of_compressed"
  [@@noalloc]

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

module Uncompressed = struct
  type t = Bytes.t

  module Scalar = Fr

  let empty () = Bytes.create 192

  let to_t (g : Bytes.t) : t = g

  let to_bytes g = g

  let of_compressed compressed =
    let g = empty () in
    ml_bls12_381_g2_uncompressed_of_compressed g compressed ;
    g

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
    ml_bls12_381_g2_add g g1 g2 ;
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
    let g = ml_bls12_381_g2_is_zero g in
    g

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = 192) ;
    assert (Bytes.length (Scalar.to_bytes a) = 32) ;
    let buffer = Bytes.create 192 in
    ml_bls12_381_g2_mul buffer g (Fr.to_bytes a) ;
    to_t buffer
end

module Compressed = struct
  type t = Bytes.t

  module Scalar = Fr

  let empty () = Bytes.create 48

  let of_uncompressed uncompressed =
    let g = empty () in
    ml_bls12_381_g2_compressed_of_uncompressed g uncompressed ;
    g

  let to_t g = g

  let to_bytes g = g

  let is_zero g = to_t @@ Uncompressed.is_zero (Uncompressed.of_compressed g)

  let zero () = to_t @@ of_uncompressed (Uncompressed.zero ())

  let one () = to_t @@ of_uncompressed (Uncompressed.one ())

  let random () = to_t @@ of_uncompressed (Uncompressed.random ())

  let add g1 g2 =
    let g1 = Uncompressed.of_compressed g1 in
    let g2 = Uncompressed.of_compressed g2 in
    let result = Uncompressed.add g1 g2 in
    to_t @@ of_uncompressed result

  (* FIXME: can be improved by creating a C binding *)
  let eq g1 g2 =
    let g1 = Uncompressed.of_compressed g1 in
    let g2 = Uncompressed.of_compressed g2 in
    to_t @@ Uncompressed.eq g1 g2

  let negate g =
    let g = Uncompressed.of_compressed g in
    let opposite = Uncompressed.negate g in
    to_t @@ of_uncompressed opposite

  let mul g a =
    let g = Uncompressed.of_compressed g in
    let result = Uncompressed.mul g a in
    to_t @@ of_uncompressed result
end
