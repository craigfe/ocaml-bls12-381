module Uncompressed =
  Bls12_381_gen.G1.MakeUncompressed
    (Fr)
    (Bls12_381_js_gen.G1.MakeUncompressedStubs (Stubs))
module Compressed =
  Bls12_381_gen.G1.MakeCompressed
    (Fr)
    (Bls12_381_js_gen.G1.MakeCompressedStubs (Stubs))

(* let compressed_of_uncompressed g =
 *   let buffer = Compressed.empty () in
 *   G1_stubs.compressed_of_uncompressed
 *     (Ctypes.ocaml_bytes_start (Compressed.to_bytes buffer))
 *     (Ctypes.ocaml_bytes_start (Uncompressed.to_bytes g)) ;
 *   Compressed.of_bytes_exn (Compressed.to_bytes buffer)
 * 
 * let uncompressed_of_compressed g =
 *   let buffer = Uncompressed.empty () in
 *   G1_stubs.uncompressed_of_compressed
 *     (Ctypes.ocaml_bytes_start (Uncompressed.to_bytes buffer))
 *     (Ctypes.ocaml_bytes_start (Compressed.to_bytes g)) ;
 *   Uncompressed.of_bytes_exn (Uncompressed.to_bytes buffer) *)
