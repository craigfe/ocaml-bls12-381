module ValueGeneration = Test_ff_make.MakeValueGeneration (Bls12_381.Fr)
module IsZero = Test_ff_make.MakeIsZero (Bls12_381.Fr)
module Equality = Test_ff_make.MakeEquality (Bls12_381.Fr)
module FieldProperties = Test_ff_make.MakeFieldProperties (Bls12_381.Fr)

module StringRepresentation = struct
  let test_to_string_one () =
    assert (String.equal "1" (Bls12_381.Fr.to_string (Bls12_381.Fr.one ())))

  let test_to_string_zero () =
    assert (String.equal "0" (Bls12_381.Fr.to_string (Bls12_381.Fr.zero ())))

  let get_tests () =
    let open Alcotest in
    ( "String representation",
      [ test_case "one" `Quick test_to_string_one;
        test_case "zero" `Quick test_to_string_zero ] )
end

let () =
  let open Alcotest in
  run
    "Fr"
    [ IsZero.get_tests ();
      ValueGeneration.get_tests ();
      Equality.get_tests ();
      FieldProperties.get_tests ();
      StringRepresentation.get_tests () ]
