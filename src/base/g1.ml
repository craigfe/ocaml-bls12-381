module type RAW_UNCOMPRESSED = sig
  include Elliptic_curve_sig.RAW_BASE

  val build_from_components : Bytes.t -> Bytes.t -> Bytes.t -> bool
end

module type RAW_COMPRESSED = sig
  include Elliptic_curve_sig.RAW_BASE
end

module type BASE = sig
  include Elliptic_curve_sig.T
end

module type UNCOMPRESSED = sig
  include BASE

  (** Create a point from the coordinates. If the point is not on the curve,
    [None] is return. The points must be given modulo the order of Fq. To create
    the point at infinity, use [zero ()] *)
  val of_z_opt : x:Z.t -> y:Z.t -> t option
end

module type COMPRESSED = sig
  include BASE
end

module MakeBase (Scalar : Fr.T) (Stubs : Elliptic_curve_sig.RAW_BASE) :
  BASE with module Scalar = Scalar = struct
  exception Not_on_curve of Bytes.t

  type t = Bytes.t

  let size_in_bytes = Stubs.size_in_bytes

  module Scalar = Scalar

  let empty () = Bytes.make size_in_bytes '\000'

  let check_bytes bs =
    if Bytes.length bs = size_in_bytes then Stubs.check_bytes bs else false

  let of_bytes_opt bs = if check_bytes bs then Some bs else None

  let of_bytes_exn (g : Bytes.t) : t =
    if check_bytes g then g else raise (Not_on_curve g)

  let to_bytes g = g

  let zero =
    let g = empty () in
    Stubs.zero g ;
    g

  let one =
    let g = empty () in
    Stubs.one g ;
    g

  let random ?state () =
    ignore state ;
    let g = empty () in
    Stubs.random g ;
    g

  let add g1 g2 =
    assert (Bytes.length g1 = size_in_bytes) ;
    assert (Bytes.length g2 = size_in_bytes) ;
    let g = empty () in
    Stubs.add g g1 g2 ;
    g

  let negate g =
    assert (Bytes.length g = size_in_bytes) ;
    let buffer = empty () in
    Stubs.negate buffer g ;
    buffer

  let eq g1 g2 =
    assert (Bytes.length g1 = size_in_bytes) ;
    assert (Bytes.length g2 = size_in_bytes) ;
    Stubs.eq g1 g2

  let is_zero g =
    assert (Bytes.length g = size_in_bytes) ;
    Stubs.is_zero g

  let double g =
    assert (Bytes.length g = size_in_bytes) ;
    let buffer = empty () in
    Stubs.double buffer g ;
    buffer

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = size_in_bytes) ;
    assert (Bytes.length (Scalar.to_bytes a) = Scalar.size_in_bytes) ;
    let buffer = empty () in
    Stubs.mul buffer g (Scalar.to_bytes a) ;
    buffer
end

module MakeUncompressed (Scalar : Fr.T) (Stubs : RAW_UNCOMPRESSED) :
  UNCOMPRESSED with module Scalar = Scalar = struct
  include MakeBase (Scalar) (Stubs)

  let of_z_opt ~x ~y =
    let x = Bytes.of_string (Z.to_bits x) in
    let y = Bytes.of_string (Z.to_bits y) in
    let buffer = empty () in
    let res = Stubs.build_from_components (to_bytes buffer) x y in
    if res = true then Some (of_bytes_exn (to_bytes buffer)) else None
end

module MakeCompressed (Scalar : Fr.T) (Stubs : RAW_COMPRESSED) :
  COMPRESSED with module Scalar = Scalar = struct
  include MakeBase (Scalar) (Stubs)
end
