module Uncompressed : G1_sig.UNCOMPRESSED with type Scalar.t = Fr.t

module Compressed : G1_sig.COMPRESSED with type Scalar.t = Fr.t

(* val compressed_of_uncompressed : Uncompressed.t -> Compressed.t
 * 
 * val uncompressed_of_compressed : Compressed.t -> Uncompressed.t *)
