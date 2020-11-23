module P =
  Bls12_381_gen.Pairing.Make (G1.Uncompressed) (G2.Uncompressed) (Fq12)
    (Bls12_381_js_gen.Pairing.MakeStubs (Stubs))
include P
