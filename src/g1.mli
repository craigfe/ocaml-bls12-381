module Uncompressed : sig
  include Elliptic_curve_sig.T with type Scalar.t = Fr.t
end

module Compressed : sig
  include Elliptic_curve_sig.T with type Scalar.t = Fr.t

  val of_uncompressed : Uncompressed.t -> t

  val to_uncompressed : t -> Uncompressed.t
end
