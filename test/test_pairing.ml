open Bls12_381

let rec repeat n f =
  if n <= 0 then
    let f () = () in
    f
  else (
    f () ;
    repeat (n - 1) f )

module Properties = struct
  let with_zero_as_first_component () =
    assert (
      Fq12.eq
        (Pairing.pairing (G1.Uncompressed.zero ()) (G2.Uncompressed.random ()))
        (Fq12.one ()) )

  let with_zero_as_second_component () =
    assert (
      Fq12.eq
        (Pairing.pairing (G1.Uncompressed.random ()) (G2.Uncompressed.zero ()))
        (Fq12.one ()) )

  let linearity_commutativity_scalar () =
    (* pairing(a * g_{1}, b * g_{2}) = pairing(b * g_{1}, a * g_{2})*)
    let a = Fr.random () in
    let b = Fr.random () in
    let g1 = G1.Uncompressed.random () in
    let g2 = G2.Uncompressed.random () in
    assert (
      Fq12.eq
        (Pairing.pairing (G1.Uncompressed.mul g1 a) (G2.Uncompressed.mul g2 b))
        (Pairing.pairing (G1.Uncompressed.mul g1 b) (G2.Uncompressed.mul g2 a))
    )
end

let () =
  let open Alcotest in
  run
    "Pairing"
    [ ( "Properties",
        [ test_case
            "with zero as first component"
            `Quick
            (repeat 1000 Properties.with_zero_as_first_component);
          test_case
            "with zero as second component"
            `Quick
            (repeat 1000 Properties.with_zero_as_second_component);
          test_case
            "linearity commutativity scalar"
            `Quick
            (repeat 1000 Properties.linearity_commutativity_scalar) ] ) ]
