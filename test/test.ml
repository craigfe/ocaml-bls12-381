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
    ]
  ]
