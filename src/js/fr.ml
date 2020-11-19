module Fr =
Bls12_381_functors.Fr_sig.MakeFr (Bls12_381_js_functors.Fr.MakeStubs (struct
  open Js_of_ocaml.Js

  let rust_module () : Jsoo_lib.ESModule.t =
    Js_of_ocaml.Firebug.console##log Unsafe.global ;
    Jsoo_lib.ESModule.of_js Unsafe.global ##. HELLO

  let get_wasm_memory_buffer () =
    Jsoo_lib_rust_wasm.Memory.Buffer.of_js
      (Unsafe.get
         (Unsafe.get (Unsafe.get (rust_module ()) "__wasm") "memory")
         "buffer")
end))

include Fr
