let rec repeat n f =
  if n <= 0 then let f () = () in f else (f (); repeat (n - 1) f)

module MakeEquality (G : Bls12_381.Elliptic_curve_sig.T) = struct
  let zero_two_different_objects () = assert (G.eq (G.zero ()) (G.zero ()))

  let zero_same_objects () =
    let zero = G.zero () in
    assert (G.eq zero zero)

  let one_two_different_objects () = assert (G.eq (G.one ()) (G.one ()))

  let one_same_objects () =
    let one = G.one () in
    assert (G.eq one one)

  let random_same_objects () =
    let random = G.random () in
    assert (G.eq random random)

  let get_tests () =
    let open Alcotest in
    ( "equality",
      [ test_case "zero_two_different_objects" `Quick (repeat 100 zero_two_different_objects);
        test_case "zero_same_objects" `Quick (repeat 100 zero_same_objects);
        test_case "one_two_different_objects" `Quick (repeat 100 one_two_different_objects);
        test_case "one_same_objects" `Quick (repeat 100 one_same_objects);
        test_case "random_same_objects" `Quick (repeat 100 random_same_objects) ] )
end

module MakeValueGeneration (G : Bls12_381.Elliptic_curve_sig.T) = struct
  let zero () = ignore @@ G.zero ()

  let random () = ignore @@ G.random ()

  let one () = ignore @@ G.one ()

  let negation_with_random () =
    let random = G.random () in
    ignore @@ G.negate random

  let negation_with_zero () =
    let zero = G.zero () in
    ignore @@ G.negate zero

  let negation_with_one () =
    let one = G.one () in
    ignore @@ G.negate one

  let get_tests () =
    let open Alcotest in
    ( "value generation",
      [ test_case "zero" `Quick (repeat 100 zero);
        test_case "random" `Quick (repeat 100 random);
        test_case "negate_with_one" `Quick (repeat 100 negation_with_one);
        test_case "negate_with_zero" `Quick (repeat 100 negation_with_zero);
        test_case "negate_with_random" `Quick (repeat 100 negation_with_random) ] )
end

module MakeIsZero (G : Bls12_381.Elliptic_curve_sig.T) = struct
  let with_zero_value () = assert (G.is_zero (G.zero ()) = true)

  let with_random_value () = assert (G.is_zero (G.random ()) = false)

  let get_tests () =
    let open Alcotest in
    ( "is_zero",
      [ test_case "with zero value" `Quick (repeat 100 with_zero_value);
        test_case "with random value" `Quick (repeat 100 with_random_value) ] )
end

module MakeECProperties (G : Bls12_381.Elliptic_curve_sig.T) = struct
  let zero_scalar_nullifier_random () =
    (* 0 * g = 0 *)
    let zero = G.Scalar.zero () in
    let random = G.random () in
    assert (G.is_zero (G.mul random zero))

  let zero_scalar_nullifier_zero () =
    (* Special case 0 * 0 = 0 *)
    let zero_fr = G.Scalar.zero () in
    let zero_g1 = G.zero () in
    assert (G.is_zero (G.mul zero_g1 zero_fr))

  let zero_scalar_nullifier_one () =
    (* Special case 0 * 1 = 0 *)
    let zero = G.Scalar.zero () in
    let one = G.one () in
    assert (G.is_zero (G.mul one zero))

  let opposite_of_opposite () =
    let random = G.random () in
    assert (G.eq (G.negate (G.negate random)) random)

  let opposite_of_zero_is_zero () =
    let zero = G.zero () in
    assert (G.eq (G.negate zero) zero)

  let additive_associativity () =
    let g1 = G.random () in
    let g2 = G.random () in
    let g3 = G.random () in
    assert (G.eq (G.add (G.add g1 g2) g3) (G.add (G.add g2 g3) g1))

  let distributivity () =
    let s = G.Scalar.random () in
    let g1 = G.random () in
    let g2 = G.random () in
    assert (G.eq (G.mul (G.add g1 g2) s) (G.add (G.mul g1 s) (G.mul g2 s)))

  let opposite_of_scalar_is_opposite_of_ec () =
    let s = G.Scalar.random () in
    let g = G.random () in
    assert (G.eq (G.mul g (G.Scalar.negate s)) (G.mul (G.negate g) s))

  let get_tests () =
    let open Alcotest in
    ( "Field properties",
      [ test_case "zero_scalar_nullifier_one" `Quick (repeat 100 zero_scalar_nullifier_one);
        test_case "zero_scalar_nullifier_zero" `Quick (repeat 100 zero_scalar_nullifier_zero);
        test_case
          "zero_scalar_nullifier_random"
          `Quick
          (repeat 100 zero_scalar_nullifier_random);
        test_case "opposite_of_opposite" `Quick (repeat 100 opposite_of_opposite);
        test_case "opposite_of_zero_is_zero" `Quick (repeat 100 opposite_of_zero_is_zero) ;
        test_case "distributivity" `Quick (repeat 100 distributivity);
        test_case
          "opposite_of_scalar_is_opposite_of_ec"
          `Quick
          (repeat 100 opposite_of_scalar_is_opposite_of_ec);
        test_case "additive_associativity" `Quick (repeat 100 additive_associativity) ] )
end
