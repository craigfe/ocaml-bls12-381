(** Check the routine generators do not raise any exception *)
module ValueGeneration =
  Test_ec_make.MakeValueGeneration (Bls12_381.G1.Uncompressed)

module IsZero = Test_ec_make.MakeIsZero (Bls12_381.G1.Uncompressed)
module Equality = Test_ec_make.MakeEquality (Bls12_381.G1.Uncompressed)
module ECProperties = Test_ec_make.MakeECProperties (Bls12_381.G1.Uncompressed)
module ValueGenerationCompressed =
  Test_ec_make.MakeValueGeneration (Bls12_381.G1.Compressed)
module IsZeroCompressed = Test_ec_make.MakeIsZero (Bls12_381.G1.Compressed)
module EqualityCompressed = Test_ec_make.MakeEquality (Bls12_381.G1.Compressed)
module ECPropertiesCompressed =
  Test_ec_make.MakeECProperties (Bls12_381.G1.Compressed)

module Constructors = struct
  let test_of_z_one () =
    (* https://github.com/zcash/librustzcash/blob/0.1.0/pairing/src/bls12_381/fq.rs#L18 *)
    let x =
      Z.of_string
        "3685416753713387016781088315183077757961620795782546409894578378688607592378376318836054947676345821548104185464507"
    in
    let y =
      Z.of_string
        "1339506544944476473020471379941921221584933875938349620426543736416511423956333506472724655353366534992391756441569"
    in
    let g = Bls12_381.G1.Uncompressed.of_z_opt ~x ~y in
    match g with
    | Some g ->
        assert (
          Bls12_381.G1.Uncompressed.eq (Bls12_381.G1.Uncompressed.one ()) g )
    | None -> assert false

  (* https://github.com/zcash/librustzcash/blob/0.1.0/pairing/src/bls12_381/ec.rs#L1196 *)
  (* https://github.com/zcash/librustzcash/blob/0.1.0/pairing/src/bls12_381/ec.rs#L1245 *)
  let test_vectors_1 () =
    let x =
      Z.of_string
        "52901198670373960614757979459866672334163627229195745167587898707663026648445040826329033206551534205133090753192"
    in
    let y =
      Z.of_string
        "1711275103908443722918766889652776216989264073722543507596490456144926139887096946237734327757134898380852225872709"
    in
    let g = Bls12_381.G1.Uncompressed.of_z_opt ~x ~y in
    match g with Some _ -> assert true | None -> assert false

  let test_vectors_2 () =
    let x =
      Z.of_string
        "128100205326445210408953809171070606737678357140298133325128175840781723996595026100005714405541449960643523234125"
    in
    let y =
      Z.of_string
        "2291134451313223670499022936083127939567618746216464377735567679979105510603740918204953301371880765657042046687078"
    in
    let g = Bls12_381.G1.Uncompressed.of_z_opt ~x ~y in
    match g with Some _ -> assert true | None -> assert false

  let test_vectors_3 () =
    let x =
      Z.of_string
        "3821408151224848222394078037104966877485040835569514006839342061575586899845797797516352881516922679872117658572470"
    in
    let y =
      Z.of_string
        "2291134451313223670499022936083127939567618746216464377735567679979105510603740918204953301371880765657042046687078"
    in
    let g = Bls12_381.G1.Uncompressed.of_z_opt ~x ~y in
    match g with Some _ -> assert true | None -> assert false

  let test_vectors_add () =
    let x_1 =
      Z.of_string
        "128100205326445210408953809171070606737678357140298133325128175840781723996595026100005714405541449960643523234125"
    in
    let y =
      Z.of_string
        "2291134451313223670499022936083127939567618746216464377735567679979105510603740918204953301371880765657042046687078"
    in
    let p1 = Bls12_381.G1.Uncompressed.of_z_opt ~x:x_1 ~y in
    let x_2 =
      Z.of_string
        "3821408151224848222394078037104966877485040835569514006839342061575586899845797797516352881516922679872117658572470"
    in
    let p2 = Bls12_381.G1.Uncompressed.of_z_opt ~x:x_2 ~y in
    let x_res =
      Z.of_string
        "52901198670373960614757979459866672334163627229195745167587898707663026648445040826329033206551534205133090753192"
    in
    let y_res =
      Z.of_string
        "1711275103908443722918766889652776216989264073722543507596490456144926139887096946237734327757134898380852225872709"
    in
    let res = Bls12_381.G1.Uncompressed.of_z_opt ~x:x_res ~y:y_res in
    match (res, p1, p2) with
    | (Some res, Some p1, Some p2) ->
        assert (
          Bls12_381.G1.Uncompressed.eq res (Bls12_381.G1.Uncompressed.add p1 p2)
        )
    | _ -> assert false

  let get_tests () =
    let open Alcotest in
    ( "From Z elements",
      [ test_case "one (generator)" `Quick test_of_z_one;
        test_case "test vectors 1" `Quick test_vectors_1;
        test_case "test vectors 2" `Quick test_vectors_2;
        test_case "test vectors 3" `Quick test_vectors_3;
        test_case "test vectors add" `Quick test_vectors_add ] )
end

let () =
  let open Alcotest in
  run
    "G1 Uncompressed"
    [ IsZero.get_tests ();
      ValueGeneration.get_tests ();
      Equality.get_tests ();
      ECProperties.get_tests ();
      Constructors.get_tests () ] ;
  run
    "G1 Compressed"
    [ IsZeroCompressed.get_tests ();
      ValueGenerationCompressed.get_tests ();
      EqualityCompressed.get_tests ();
      ECPropertiesCompressed.get_tests () ]
