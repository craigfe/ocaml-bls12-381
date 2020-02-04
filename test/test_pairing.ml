open Bls12_381

module Properties = struct
  let with_zero_as_first_component () =
    assert (Fq12.eq (Pairing.pairing (G1.zero ()) (G2.random ())) (Fq12.zero ()))
end

let () =
  let open Alcotest in
  run
    "Pairing"
    [ ( "Properties",
        [ test_case
            "with zero as first component"
            `Quick
            Properties.with_zero_as_first_component ] ) ]
