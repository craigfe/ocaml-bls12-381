(** Check the routine generators do not raise any exception *)
module ValueGeneration =
  Test_ec_make.MakeValueGeneration (Bls12_381.G1.Uncompressed)

module IsZero = Test_ec_make.MakeIsZero (Bls12_381.G1.Uncompressed)
module Equality = Test_ec_make.MakeEquality (Bls12_381.G1.Uncompressed)
module ECProperties = Test_ec_make.MakeECProperties (Bls12_381.G1.Uncompressed)

let () =
  let open Alcotest in
  run
    "G1"
    [ IsZero.get_tests ();
      ValueGeneration.get_tests ();
      Equality.get_tests ();
      ECProperties.get_tests () ]
