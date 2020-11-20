module P =
  Bls12_381_gen.Pairing.Make (G1.Uncompressed) (G2.Uncompressed) (Fq12)
    (Bls12_381_js_functors.Pairing.MakeStubs (struct
      open Js_of_ocaml.Js

      let rust_module () : Jsoo_lib.ESModule.t =
        Jsoo_lib.ESModule.of_js Unsafe.global ##. RUSTC_BLS12_381

      let get_wasm_memory_buffer () =
        Jsoo_lib_rust_wasm.Memory.Buffer.of_js
          (Unsafe.get
             (Unsafe.get (Unsafe.get (rust_module ()) "__wasm") "memory")
             "buffer")
    end))

include P
