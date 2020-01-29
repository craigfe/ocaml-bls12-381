(** Check the routine generators do not raise any exception *)
module ValueGeneration = struct
  let zero () =
    ignore @@ (Bls12_381.Fq.zero ())
  let random () =
    ignore @@ (Bls12_381.Fq.random ())

end

module IsZero = struct
  let with_zero_value () =
    assert(Bls12_381.Fq.is_zero (Bls12_381.Fq.zero ()) = true)
  let with_random_value () =
    assert(Bls12_381.Fq.is_zero (Bls12_381.Fq.random ()) = false)
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
end

let () =
  let open Alcotest in
  run "Fq" [
    "is_zero", [
       test_case "with zero value" `Quick IsZero.with_zero_value;
       test_case "with random value" `Quick IsZero.with_random_value;
    ];
    "value generation", [
       test_case "zero" `Quick ValueGeneration.zero;
       test_case "random" `Quick ValueGeneration.random;
    ];
    "Field properties", [
       test_case "zero_nullifier_one" `Quick FieldProperties.zero_nullifier_one;
       test_case "zero_nullifier_zero" `Quick FieldProperties.zero_nullifier_zero;
       test_case "zero_nullifier_random" `Quick FieldProperties.zero_nullifier_random;
    ];
  ]
