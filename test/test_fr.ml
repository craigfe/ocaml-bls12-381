let rec repeat n f =
  if n <= 0 then
    let f () = () in
    f
  else (
    f () ;
    repeat (n - 1) f )

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

module ZRepresentation = struct
  let test_of_z_zero () =
    assert (Bls12_381.Fr.eq (Bls12_381.Fr.zero ()) (Bls12_381.Fr.of_z (Z.zero)))

  let test_of_z_one () =
    assert (Bls12_381.Fr.eq (Bls12_381.Fr.one ()) (Bls12_381.Fr.of_z (Z.of_string "1")))

  let test_of_z_and_to_z () =
    let x = Bls12_381.Fr.random () in
    assert (Bls12_381.Fr.eq x (Bls12_381.Fr.of_z (Bls12_381.Fr.to_z x)))

  let test_to_z_and_of_z () =
    let x = Z.of_int (Random.int 2_000_000) in
    assert (Z.equal (Bls12_381.Fr.to_z (Bls12_381.Fr.of_z x)) x)

  let get_tests () =
    let open Alcotest in
    ( "Z representation",
      [ test_case "one" `Quick test_of_z_one;
        test_case "zero" `Quick test_of_z_zero;
        test_case "of z and to z" `Quick (repeat 1000 test_of_z_and_to_z);
        test_case "to z and of z" `Quick (repeat 1000 test_to_z_and_of_z)
 ] )
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
