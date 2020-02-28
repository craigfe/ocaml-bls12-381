external ml_bls12_381_g2_uncompressed_is_on_curve : Bytes.t -> bool
  = "ml_librustc_bls12_381_g2_uncompressed_is_on_curve"
  [@@noalloc]

external ml_bls12_381_g2_compressed_is_on_curve : Bytes.t -> bool
  = "ml_librustc_bls12_381_g2_compressed_is_on_curve"
  [@@noalloc]

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

  let size = 192

  module Scalar = Fr

  let empty () = Bytes.create size

  let is_on_curve bs =
    if Bytes.length bs = size then ml_bls12_381_g2_uncompressed_is_on_curve bs
    else false

  let of_bytes_opt bs = if is_on_curve bs then Some bs else None

  let of_bytes (g : Bytes.t) : t = g

  let to_bytes g = g

  let zero () =
    let g = empty () in
    ml_bls12_381_g2_zero g ;
    of_bytes g

  let one () =
    let g = empty () in
    ml_bls12_381_g2_one g ;
    of_bytes g

  let random () =
    let g = empty () in
    ml_bls12_381_g2_random g ;
    of_bytes g

  let add g1 g2 =
    assert (Bytes.length g1 = size) ;
    assert (Bytes.length g2 = size) ;
    let g = empty () in
    ml_bls12_381_g2_add g g1 g2 ;
    of_bytes g

  let negate g =
    assert (Bytes.length g = size) ;
    let buffer = empty () in
    ml_bls12_381_g2_negate buffer g ;
    of_bytes buffer

  let eq g1 g2 =
    assert (Bytes.length g1 = size) ;
    assert (Bytes.length g2 = size) ;
    ml_bls12_381_g2_eq g1 g2

  let is_zero g =
    assert (Bytes.length g = size) ;
    let g = ml_bls12_381_g2_is_zero g in
    g

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = size) ;
    assert (Bytes.length (Scalar.to_bytes a) = Scalar.size) ;
    let buffer = empty () in
    ml_bls12_381_g2_mul buffer g (Scalar.to_bytes a) ;
    of_bytes buffer
end

module Compressed = struct
  type t = Bytes.t

  let size = 96

  module Scalar = Fr

  let empty () = Bytes.create size

  let of_uncompressed uncompressed =
    let g = empty () in
    ml_bls12_381_g2_compressed_of_uncompressed g uncompressed ;
    g

  let to_uncompressed compressed =
    let g = Uncompressed.empty () in
    ml_bls12_381_g2_uncompressed_of_compressed g compressed ;
    g

  let is_on_curve bs =
    if Bytes.length bs = size then ml_bls12_381_g2_compressed_is_on_curve bs
    else false

  let of_bytes_opt bs = if is_on_curve bs then Some bs else None

  let of_bytes g = g

  let to_bytes g = g

  let is_zero g = Uncompressed.is_zero (to_uncompressed g)

  let zero () = of_bytes @@ of_uncompressed (Uncompressed.zero ())

  let one () = of_bytes @@ of_uncompressed (Uncompressed.one ())

  let random () = of_bytes @@ of_uncompressed (Uncompressed.random ())

  let add g1 g2 =
    assert (Bytes.length g1 = size) ;
    assert (Bytes.length g2 = size) ;
    let g1 = to_uncompressed g1 in
    let g2 = to_uncompressed g2 in
    let result = Uncompressed.add g1 g2 in
    of_bytes @@ of_uncompressed result

  (* FIXME: can be improved by creating a C binding *)
  let eq g1 g2 =
    assert (Bytes.length g1 = size) ;
    assert (Bytes.length g2 = size) ;
    let g1 = to_uncompressed g1 in
    let g2 = to_uncompressed g2 in
    of_bytes @@ Uncompressed.eq g1 g2

  let negate g =
    assert (Bytes.length g = size) ;
    let g = to_uncompressed g in
    let opposite = Uncompressed.negate g in
    of_bytes @@ of_uncompressed opposite

  let mul g a =
    assert (Bytes.length g = size) ;
    assert (Bytes.length (Scalar.to_bytes a) = Scalar.size) ;
    let g = to_uncompressed g in
    let result = Uncompressed.mul g a in
    of_bytes @@ of_uncompressed result
end
