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

external ml_bls12_381_g2_compressed_random : Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_random"
  [@@noalloc]

external ml_bls12_381_g2_compressed_add : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_add"
  [@@noalloc]

external ml_bls12_381_g2_compressed_negate : Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_negate"
  [@@noalloc]

external ml_bls12_381_g2_compressed_eq : Bytes.t -> Bytes.t -> bool
  = "ml_librustc_bls12_381_g2_compressed_eq"
  [@@noalloc]

external ml_bls12_381_g2_compressed_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_g2_compressed_is_zero"
  [@@noalloc]

external ml_bls12_381_g2_compressed_mul : Bytes.t -> Bytes.t -> Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_mul"
  [@@noalloc]

external ml_bls12_381_g2_compressed_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_zero"
  [@@noalloc]

external ml_bls12_381_g2_compressed_one : Bytes.t -> unit
  = "ml_librustc_bls12_381_g2_compressed_one"
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

  let zero () =
    let g = empty () in
    ml_bls12_381_g2_compressed_zero g ;
    of_bytes g

  let one () =
    let g = empty () in
    ml_bls12_381_g2_compressed_one g ;
    of_bytes g

  let random () =
    let g = empty () in
    ml_bls12_381_g2_compressed_random g ;
    of_bytes g

  let add g1 g2 =
    assert (Bytes.length g1 = size) ;
    assert (Bytes.length g2 = size) ;
    let g = empty () in
    ml_bls12_381_g2_compressed_add g g1 g2 ;
    of_bytes g

  let negate g =
    assert (Bytes.length g = size) ;
    let buffer = empty () in
    ml_bls12_381_g2_compressed_negate buffer g ;
    of_bytes buffer

  let eq g1 g2 =
    assert (Bytes.length g1 = size) ;
    assert (Bytes.length g2 = size) ;
    ml_bls12_381_g2_compressed_eq g1 g2

  let is_zero g =
    assert (Bytes.length g = size) ;
    let g = ml_bls12_381_g2_compressed_is_zero g in
    g

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = size) ;
    assert (Bytes.length (Scalar.to_bytes a) = Scalar.size) ;
    let buffer = empty () in
    ml_bls12_381_g2_compressed_mul buffer g (Fr.to_bytes a) ;
    of_bytes buffer
end
