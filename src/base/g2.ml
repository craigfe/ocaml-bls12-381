module type RAW_UNCOMPRESSED = sig
  include Elliptic_curve_sig.RAW_BASE

  val build_from_components :
    Bytes.t -> Bytes.t -> Bytes.t -> Bytes.t -> Bytes.t option
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
      None is return. The points must be given modulo the order of Fq. The
      points are in the form (c0, c1) where x = c1 * X + c0 and y = c1 * X +
      c0. To create the point at infinity, use [zero ()] *)
  val of_z_opt : x:Z.t * Z.t -> y:Z.t * Z.t -> t option
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
    let res = Stubs.zero () in
    res

  let one =
    let res = Stubs.one () in
    res

  let random ?state () =
    ignore state ;
    let res = Stubs.random () in
    res

  let add g1 g2 =
    assert (Bytes.length g1 = size_in_bytes) ;
    assert (Bytes.length g2 = size_in_bytes) ;
    let res = Stubs.add g1 g2 in
    assert (Bytes.length res = size_in_bytes) ;
    res

  let negate g =
    assert (Bytes.length g = size_in_bytes) ;
    let res = Stubs.negate g in
    assert (Bytes.length res = size_in_bytes) ;
    res

  let eq g1 g2 =
    assert (Bytes.length g1 = size_in_bytes) ;
    assert (Bytes.length g2 = size_in_bytes) ;
    Stubs.eq g1 g2

  let is_zero g =
    assert (Bytes.length g = size_in_bytes) ;
    Stubs.is_zero g

  let double g =
    assert (Bytes.length g = size_in_bytes) ;
    let res = Stubs.double g in
    assert (Bytes.length res = size_in_bytes) ;
    res

  let mul (g : t) (a : Scalar.t) : t =
    assert (Bytes.length g = size_in_bytes) ;
    assert (Bytes.length (Scalar.to_bytes a) = Scalar.size_in_bytes) ;
    let res = Stubs.mul g (Scalar.to_bytes a) in
    assert (Bytes.length res = size_in_bytes) ;
    res
end

module MakeUncompressed (Scalar : Fr.T) (Stubs : RAW_UNCOMPRESSED) :
  UNCOMPRESSED with module Scalar = Scalar = struct
  include MakeBase (Scalar) (Stubs)

  let of_z_opt ~x ~y =
    let (x_1, x_2) = x in
    let (y_1, y_2) = y in
    let x_1 = Bytes.of_string (Z.to_bits x_1) in
    let x_2 = Bytes.of_string (Z.to_bits x_2) in
    let y_1 = Bytes.of_string (Z.to_bits y_1) in
    let y_2 = Bytes.of_string (Z.to_bits y_2) in
    let res = Stubs.build_from_components x_1 x_2 y_1 y_2 in
    match res with None -> None | Some res -> Some (of_bytes_exn res)
end

module MakeCompressed (Scalar : Fr.T) (Stubs : RAW_COMPRESSED) :
  COMPRESSED with module Scalar = Scalar = struct
  include MakeBase (Scalar) (Stubs)
end
