let () =
  let open Js_of_ocaml.Js in
  let p : Jsoo_lib.ESModule.t =
    Jsoo_lib.ESModule.of_js
      (Unsafe.js_expr {| require("@dannywillems/rustc-bls12-381-node") |})
  in
  (* let on_resolved m = *)
  let module StubsFq12 = Bls12_381_js.Fq12.MakeStubs (struct
    let rust_module = p

    let wasm_memory_buffer =
      Jsoo_lib_rust_wasm.Memory.Buffer.of_js
        (Unsafe.get (Unsafe.get (Unsafe.get p "__wasm") "memory") "buffer")
  end) in
  let module Fq12 = Bls12_381_base.Fq12.MakeFq12 (StubsFq12) in
  let module ValueGeneration = Test_ff_make.MakeValueGeneration (Fq12) in
  let module IsZero = Test_ff_make.MakeIsZero (Fq12) in
  let module Equality = Test_ff_make.MakeEquality (Fq12) in
  let module ECProperties = Test_ff_make.MakeFieldProperties (Fq12) in
  let open Alcotest in
  run
    "Fq12"
    [ IsZero.get_tests ();
      ValueGeneration.get_tests ();
      Equality.get_tests ();
      ECProperties.get_tests () ]
