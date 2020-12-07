let () =
  (* let on_resolved m = *)
  let module StubsFq12 = Bls12_381_js_gen.Fq12.MakeStubs (Stubs_node) in
  let module Fq12 = Bls12_381_gen.Fq12.MakeFq12 (StubsFq12) in
  let module Tests = Ff_pbt.MakeAll (Fq12) in
  let open Alcotest in
  run "Fq12" (Tests.get_tests ())
