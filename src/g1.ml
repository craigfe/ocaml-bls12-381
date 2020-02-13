external ml_bls12_381_g1_compressed_of_uncompressed : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_of_uncompressed"
  [@@noalloc]

external ml_bls12_381_g1_uncompressed_of_compressed : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_uncompressed_of_compressed"
  [@@noalloc]

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

module Uncompressed = struct
  type t = Bytes.t

  module Scalar = Fr

  let empty () = Bytes.create 96

  let to_t (g : Bytes.t) : t = g

  let to_bytes g = g

  let zero () =
    let g = empty () in
    ml_bls12_381_g1_zero g ;
    to_t g

  let one () =
    let g = empty () in
    ml_bls12_381_g1_one g ;
    to_t g

  let random () =
    let g = empty () in
    ml_bls12_381_g1_random g ;
    to_t g

  let add g1 g2 =
    assert (Bytes.length g1 = 96) ;
    assert (Bytes.length g2 = 96) ;
    let g = empty () in
    ml_bls12_381_g1_add g g1 g2 ;
    to_t g

  let negate g =
    assert (Bytes.length g = 96) ;
    let buffer = empty () in
    ml_bls12_381_g1_negate buffer g ;
    to_t buffer

  let eq g1 g2 =
    assert (Bytes.length g1 = 96) ;
    assert (Bytes.length g2 = 96) ;
    ml_bls12_381_g1_eq g1 g2

  let is_zero g =
    assert (Bytes.length g = 96) ;
    ml_bls12_381_g1_is_zero g

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = 96) ;
    assert (Bytes.length (Fr.to_bytes a) = 32) ;
    let buffer = empty () in
    ml_bls12_381_g1_mul buffer g (Scalar.to_bytes a) ;
    to_t buffer
end

module Compressed = struct
  type t = Bytes.t

  module Scalar = Fr

  let empty () = Bytes.create 48

  let to_uncompressed (compressed : t) : Uncompressed.t =
    let g = Uncompressed.empty () in
    ml_bls12_381_g1_uncompressed_of_compressed g compressed ;
    g

  let of_uncompressed (uncompressed : Uncompressed.t) : t =
    let g = empty () in
    ml_bls12_381_g1_compressed_of_uncompressed g uncompressed ;
    g

  let to_t g = g

  let to_bytes g = g

  let is_zero g = Uncompressed.is_zero @@ to_uncompressed g

  let zero () = to_t @@ of_uncompressed (Uncompressed.zero ())

  let one () = to_t @@ of_uncompressed (Uncompressed.one ())

  let random () = to_t @@ of_uncompressed (Uncompressed.random ())

  let add g1 g2 =
    let g1 = to_uncompressed g1 in
    let g2 = to_uncompressed g2 in
    let result = Uncompressed.add g1 g2 in
    to_t @@ of_uncompressed result

  (* FIXME: can be improved by creating a C binding *)
  let eq g1 g2 =
    let g1 = to_uncompressed g1 in
    let g2 = to_uncompressed g2 in
    to_t @@ Uncompressed.eq g1 g2

  let negate g =
    let g = to_uncompressed g in
    let opposite = Uncompressed.negate g in
    to_t @@ of_uncompressed opposite

  let mul g a =
    let g = to_uncompressed g in
    let result = Uncompressed.mul g a in
    to_t @@ of_uncompressed result
end
