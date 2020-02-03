(** Check the routine generators do not raise any exception *)
module ValueGeneration = struct
  let zero () = ignore @@ Bls12_381.G1.zero ()

  let random () = ignore @@ Bls12_381.G1.random ()

  let one () = ignore @@ Bls12_381.G1.one ()

  let negation_with_random () =
    let random = Bls12_381.G1.random () in
    ignore @@ Bls12_381.G1.negate random

  let negation_with_zero () =
    let zero = Bls12_381.G1.zero () in
    ignore @@ Bls12_381.G1.negate zero

  let negation_with_one () =
    let one = Bls12_381.G1.one () in
    ignore @@ Bls12_381.G1.negate one
end

module IsZero = struct
  let with_zero_value () =
    assert (Bls12_381.G1.is_zero (Bls12_381.G1.zero ()) = true)

  let with_random_value () =
    assert (Bls12_381.G1.is_zero (Bls12_381.G1.random ()) = false)
end

module Equality = struct
  let zero_two_different_objects () =
    assert (Bls12_381.G1.eq (Bls12_381.G1.zero ()) (Bls12_381.G1.zero ()))

  let zero_same_objects () =
    let zero = Bls12_381.G1.zero () in
    assert (Bls12_381.G1.eq zero zero)

  let one_two_different_objects () =
    assert (Bls12_381.G1.eq (Bls12_381.G1.one ()) (Bls12_381.G1.one ()))

  let one_same_objects () =
    let one = Bls12_381.G1.one () in
    assert (Bls12_381.G1.eq one one)

  let random_same_objects () =
    let random = Bls12_381.G1.random () in
    assert (Bls12_381.G1.eq random random)
end

module ECProperties = struct
  let zero_scalar_nullifier_random () =
    (* 0 * g = 0 *)
    let zero = Bls12_381.Fr.zero () in
    let random = Bls12_381.G1.random () in
    assert (Bls12_381.G1.is_zero (Bls12_381.G1.mul random zero))

  let zero_scalar_nullifier_zero () =
    (* Special case 0 * 0 = 0 *)
    let zero_fr = Bls12_381.Fr.zero () in
    let zero_g1 = Bls12_381.G1.zero () in
    assert (Bls12_381.G1.is_zero (Bls12_381.G1.mul zero_g1 zero_fr))

  let zero_scalar_nullifier_one () =
    (* Special case 0 * 1 = 0 *)
    let zero = Bls12_381.Fr.zero () in
    let one = Bls12_381.G1.one () in
    assert (Bls12_381.G1.is_zero (Bls12_381.G1.mul one zero))

  let opposite_of_opposite () =
    let random = Bls12_381.G1.random () in
    assert (
      Bls12_381.G1.eq (Bls12_381.G1.negate (Bls12_381.G1.negate random)) random
    )

  let opposite_of_zero_is_zero () =
    let zero = Bls12_381.G1.zero () in
    assert (Bls12_381.G1.eq (Bls12_381.G1.negate zero) zero)

  let additive_associativity () =
    let g1 = Bls12_381.G1.random () in
    let g2 = Bls12_381.G1.random () in
    let g3 = Bls12_381.G1.random () in
    assert (
      Bls12_381.G1.eq
        (Bls12_381.G1.add (Bls12_381.G1.add g1 g2) g3)
        (Bls12_381.G1.add (Bls12_381.G1.add g2 g3) g1) )

  let distributivity () =
    let s = Bls12_381.Fr.random () in
    let g1 = Bls12_381.G1.random () in
    let g2 = Bls12_381.G1.random () in
    assert (
      Bls12_381.G1.eq
        (Bls12_381.G1.mul (Bls12_381.G1.add g1 g2) s)
        (Bls12_381.G1.add (Bls12_381.G1.mul g1 s) (Bls12_381.G1.mul g2 s)) )
end

let () =
  let open Alcotest in
  run
    "Fr"
    [ ( "is_zero",
        [ test_case "with zero value" `Quick IsZero.with_zero_value;
          test_case "with random value" `Quick IsZero.with_random_value ] );
      ( "value generation",
        [ test_case "zero" `Quick ValueGeneration.zero;
          test_case "random" `Quick ValueGeneration.random;
          test_case "negate_with_one" `Quick ValueGeneration.negation_with_one;
          test_case "negate_with_zero" `Quick ValueGeneration.negation_with_zero;
          test_case
            "negate_with_random"
            `Quick
            ValueGeneration.negation_with_random ] );
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
            "zero_scalar_nullifier_one"
            `Quick
            ECProperties.zero_scalar_nullifier_one;
          test_case
            "zero_scalar_nullifier_zero"
            `Quick
            ECProperties.zero_scalar_nullifier_zero;
          test_case
            "zero_scalar_nullifier_random"
            `Quick
            ECProperties.zero_scalar_nullifier_random;
          test_case
            "opposite_of_opposite"
            `Quick
            ECProperties.opposite_of_opposite;
          test_case
            "opposite_of_zero_is_zero"
            `Quick
            ECProperties.opposite_of_zero_is_zero;
          test_case "distributivity" `Quick ECProperties.distributivity;
          test_case
            "additive_associativity"
            `Quick
            ECProperties.additive_associativity ] ) ]
