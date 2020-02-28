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

(* ---------------- G1 Compressed ------------ *)
external ml_bls12_381_g1_compressed_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_add"
  [@@noalloc]

external ml_bls12_381_g1_compressed_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_negate"
  [@@noalloc]

external ml_bls12_381_g1_compressed_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_g1_compressed_eq"
  [@@noalloc]

external ml_bls12_381_g1_compressed_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_g1_compressed_is_zero"
  [@@noalloc]

external ml_bls12_381_g1_compressed_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_mul"
  [@@noalloc]

external ml_bls12_381_g1_compressed_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_zero"
  [@@noalloc]

external ml_bls12_381_g1_compressed_one : Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_one"
  [@@noalloc]

external ml_bls12_381_g1_compressed_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_g1_compressed_random"
  [@@noalloc]

module Uncompressed = struct
  type t = Bytes.t

  module Scalar = Fr

  let empty () = Bytes.create 96

  let of_bytes (g : Bytes.t) : t = g

  let to_bytes g = g

  let zero () =
    let g = empty () in
    ml_bls12_381_g1_zero g ;
    of_bytes g

  let one () =
    let g = empty () in
    ml_bls12_381_g1_one g ;
    of_bytes g

  let random () =
    let g = empty () in
    ml_bls12_381_g1_random g ;
    of_bytes g

  let add g1 g2 =
    assert (Bytes.length g1 = 96) ;
    assert (Bytes.length g2 = 96) ;
    let g = empty () in
    ml_bls12_381_g1_add g g1 g2 ;
    of_bytes g

  let negate g =
    assert (Bytes.length g = 96) ;
    let buffer = empty () in
    ml_bls12_381_g1_negate buffer g ;
    of_bytes buffer

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
    of_bytes buffer
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

  let of_bytes g = g

  let to_bytes g = g

  let is_zero g =
    assert (Bytes.length g = 48) ;
    ml_bls12_381_g1_compressed_is_zero g

  let zero () =
    let g = empty () in
    ml_bls12_381_g1_compressed_zero g ;
    of_bytes g

  let one () =
    let g = empty () in
    ml_bls12_381_g1_compressed_one g ;
    of_bytes g

  let random () =
    let g = empty () in
    ml_bls12_381_g1_compressed_random g ;
    of_bytes g

  let add g1 g2 =
    assert (Bytes.length g1 = 48) ;
    assert (Bytes.length g2 = 48) ;
    let g = empty () in
    ml_bls12_381_g1_compressed_add g g1 g2 ;
    of_bytes g

  let negate g =
    assert (Bytes.length g = 48) ;
    let buffer = empty () in
    ml_bls12_381_g1_compressed_negate buffer g ;
    of_bytes buffer

  let eq g1 g2 =
    assert (Bytes.length g1 = 48) ;
    assert (Bytes.length g2 = 48) ;
    ml_bls12_381_g1_compressed_eq g1 g2

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = 48) ;
    assert (Bytes.length (Fr.to_bytes a) = 32) ;
    let buffer = empty () in
    ml_bls12_381_g1_compressed_mul buffer g (Scalar.to_bytes a) ;
    of_bytes buffer
end
