module Uncompressed =
  Bls12_381_gen.G1.MakeUncompressed
    (Fr)
    (Bls12_381_js_gen.G1.MakeUncompressedStubs (struct
      open Js_of_ocaml.Js

      let rust_module () : Jsoo_lib.ESModule.t =
        Jsoo_lib.ESModule.of_js Unsafe.global ##. RUSTC_BLS12_381

      let get_wasm_memory_buffer () =
        Jsoo_lib_rust_wasm.Memory.Buffer.of_js
          (Unsafe.get
             (Unsafe.get (Unsafe.get (rust_module ()) "__wasm") "memory")
             "buffer")
    end))

module Compressed =
  Bls12_381_gen.G1.MakeCompressed
    (Fr)
    (Bls12_381_js_gen.G1.MakeCompressedStubs (struct
      open Js_of_ocaml.Js

      let rust_module () : Jsoo_lib.ESModule.t =
        Jsoo_lib.ESModule.of_js Unsafe.global ##. RUSTC_BLS12_381

      let get_wasm_memory_buffer () =
        Jsoo_lib_rust_wasm.Memory.Buffer.of_js
          (Unsafe.get
             (Unsafe.get (Unsafe.get (rust_module ()) "__wasm") "memory")
             "buffer")
    end))

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
