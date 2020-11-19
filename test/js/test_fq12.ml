let () =
  (* let on_resolved m = *)
  let module StubsFq12 = Bls12_381_js_functors.Fq12.MakeStubs (Stubs_node) in
  let module Fq12 = Bls12_381_functors.Fq12_sig.MakeFq12 (StubsFq12) in
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
