module ValueGeneration = Test_ff_make.MakeValueGeneration (Bls12_381.Fr)
module IsZero = Test_ff_make.MakeIsZero (Bls12_381.Fr)
module Equality = Test_ff_make.MakeEquality (Bls12_381.Fr)
module FieldProperties = Test_ff_make.MakeFieldProperties (Bls12_381.Fr)

let () =
  let open Alcotest in
  run
    "Fr"
    [ IsZero.get_tests ();
      ValueGeneration.get_tests ();
      Equality.get_tests ();
      FieldProperties.get_tests () ]
