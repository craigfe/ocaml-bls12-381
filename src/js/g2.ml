module Uncompressed =
  Bls12_381_gen.G2.MakeUncompressed
    (Fr)
    (Bls12_381_js_gen.G2.MakeUncompressedStubs (Stubs))
module Compressed =
  Bls12_381_gen.G2.MakeCompressed
    (Fr)
    (Bls12_381_js_gen.G2.MakeCompressedStubs (Stubs))

(* let compressed_of_uncompressed g =
 *   let buffer = Compressed.empty () in
 *   G2_stubs.compressed_of_uncompressed
 *     (Ctypes.ocaml_bytes_start (Compressed.to_bytes buffer))
 *     (Ctypes.ocaml_bytes_start (Uncompressed.to_bytes g)) ;
 *   Compressed.of_bytes_exn (Compressed.to_bytes buffer)
 * 
 * let uncompressed_of_compressed g =
 *   let buffer = Uncompressed.empty () in
 *   G2_stubs.uncompressed_of_compressed
 *     (Ctypes.ocaml_bytes_start (Uncompressed.to_bytes buffer))
 *     (Ctypes.ocaml_bytes_start (Compressed.to_bytes g)) ;
 *   Uncompressed.of_bytes_exn (Uncompressed.to_bytes buffer) *)
