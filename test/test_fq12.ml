module Tests = Ff_pbt.MakeAll (Bls12_381.Fq12)

let () =
  let open Alcotest in
  run "Fq12" (Tests.get_tests ())
