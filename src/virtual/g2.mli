module Uncompressed : G2_sig.UNCOMPRESSED with type Scalar.t = Fr.t

module Compressed : G2_sig.COMPRESSED with type Scalar.t = Fr.t

(* val compressed_of_uncompressed : Uncompressed.t -> Compressed.t
 * 
 * val uncompressed_of_compressed : Compressed.t -> Uncompressed.t *)
