module Uncompressed : Bls12_381_base.G1.UNCOMPRESSED with type Scalar.t = Fr.t

module Compressed : Bls12_381_base.G1.COMPRESSED with type Scalar.t = Fr.t

val compressed_of_uncompressed : Uncompressed.t -> Compressed.t

val uncompressed_of_compressed : Compressed.t -> Uncompressed.t
