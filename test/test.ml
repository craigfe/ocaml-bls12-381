(** Check the routine generators do not raise any exception *)
module ValueGeneration = struct
  let zero () = ignore @@ Bls12_381.Fq.zero ()

  let random () = ignore @@ Bls12_381.Fq.random ()

  let one () = ignore @@ Bls12_381.Fq.one ()

  let rec inverse_with_random_not_null () =
    let random = Bls12_381.Fq.random () in
    if Bls12_381.Fq.is_zero random then inverse_with_random_not_null ()
    else ignore @@ Bls12_381.Fq.inverse random

  let inverse_with_one () =
    let one = Bls12_381.Fq.one () in
    ignore @@ Bls12_381.Fq.inverse one
end

module IsZero = struct
  let with_zero_value () =
    assert (Bls12_381.Fq.is_zero (Bls12_381.Fq.zero ()) = true)

  let with_random_value () =
    assert (Bls12_381.Fq.is_zero (Bls12_381.Fq.random ()) = false)
end

module Equality = struct
  let zero_two_different_objects () =
    assert (Bls12_381.Fq.eq (Bls12_381.Fq.zero ()) (Bls12_381.Fq.zero ()))

  let zero_same_objects () =
    let zero = Bls12_381.Fq.zero () in
    assert (Bls12_381.Fq.eq zero zero)

  let one_two_different_objects () =
    assert (Bls12_381.Fq.eq (Bls12_381.Fq.one ()) (Bls12_381.Fq.one ()))

  let one_same_objects () =
    let one = Bls12_381.Fq.one () in
    assert (Bls12_381.Fq.eq one one)

  let random_same_objects () =
    let random = Bls12_381.Fq.random () in
    assert (Bls12_381.Fq.eq random random)
end

module FieldProperties = struct
  let zero_nullifier_random () =
    (* 0 * g = 0 *)
    let zero = Bls12_381.Fq.zero () in
    let random = Bls12_381.Fq.random () in
    assert (Bls12_381.Fq.is_zero (Bls12_381.Fq.mul zero random))

  let zero_nullifier_zero () =
    (* Special case 0 * 0 = 0 *)
    let zero = Bls12_381.Fq.zero () in
    assert (Bls12_381.Fq.is_zero (Bls12_381.Fq.mul zero zero))

  let zero_nullifier_one () =
    (* Special case 0 * 1 = 0 *)
    let zero = Bls12_381.Fq.zero () in
    let one = Bls12_381.Fq.one () in
    assert (Bls12_381.Fq.is_zero (Bls12_381.Fq.mul zero one))

  let inverse_of_one_is_one () =
    let one = Bls12_381.Fq.one () in
    assert (Bls12_381.Fq.eq (Bls12_381.Fq.inverse one) one)

  let zero_has_no_inverse () =
    let zero = Bls12_381.Fq.zero () in
    match Bls12_381.Fq.inverse_opt zero with
    | Some(_) -> assert(false)
    | None -> assert(true)

  let rec inverse_of_non_null_does_exist () =
    let random = Bls12_381.Fq.random () in
    if Bls12_381.Fq.is_zero random then inverse_of_non_null_does_exist ()
    else match Bls12_381.Fq.inverse_opt random with
    | Some(_) -> assert(true)
    | None -> assert(false)

  let rec inverse_of_inverse () =
    let random = Bls12_381.Fq.random () in
    if Bls12_381.Fq.is_zero random then inverse_of_inverse ()
    else assert(Bls12_381.Fq.eq (Bls12_381.Fq.inverse (Bls12_381.Fq.inverse random)) random)

end

let () =
  let open Alcotest in
  run
    "Fq"
    [ ( "is_zero",
        [ test_case "with zero value" `Quick IsZero.with_zero_value;
          test_case "with random value" `Quick IsZero.with_random_value ] );
      ( "value generation",
        [ test_case "zero" `Quick ValueGeneration.zero;
          test_case "random" `Quick ValueGeneration.random;
          test_case "inverse_random_not_null" `Quick ValueGeneration.inverse_with_random_not_null;
          test_case "inverse_one" `Quick ValueGeneration.inverse_with_one ] );
      ( "equality",
        [ test_case
            "zero_two_different_objects"
            `Quick
            Equality.zero_two_different_objects;
          test_case "zero_same_objects" `Quick Equality.zero_same_objects;
          test_case
            "one_two_different_objects"
            `Quick
            Equality.one_two_different_objects;
          test_case "one_same_objects" `Quick Equality.one_same_objects;
          test_case "random_same_objects" `Quick Equality.random_same_objects ]
      );
      ( "Field properties",
        [ test_case
            "zero_nullifier_one"
            `Quick
            FieldProperties.zero_nullifier_one;
          test_case
            "zero_nullifier_zero"
            `Quick
            FieldProperties.zero_nullifier_zero;
          test_case
            "zero_nullifier_random"
            `Quick
            FieldProperties.zero_nullifier_random;
          test_case
            "inverse_of_non_null_does_exist"
            `Quick
            FieldProperties.inverse_of_non_null_does_exist;
          test_case
            "inverse_of_one_is_one"
            `Quick
            FieldProperties.inverse_of_one_is_one;
          test_case
            "zero_has_no_inverse"
            `Quick
            FieldProperties.zero_has_no_inverse;
          test_case
            "inverse_of_inverse"
            `Quick
            FieldProperties.inverse_of_inverse;

 ] ) ]
