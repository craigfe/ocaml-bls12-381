let test_vectors =
  [ "5241434266765085153989819426158356963249585137477420674959011812945457865191";
    "10839440052692226066497714164180551800338639216929046788248680350103009908352";
    "45771516566988367809715142190959127910391288669516577059039340716912455457131";
    "12909915968096385929046240252673624834885730199746273136167032454235900707423";
    "9906806778085203695146840231942453635945512651510460213691437498308396392030";
    "20451006147593515828371694915490427948041026610654337997907355913265840025855";
    "22753274685202779061111872324861161292260930710591061598808549358079414450472";
    "12823588949385074189879212809942339506958509313775057573450243545256259992541"
  ]

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

  let test_of_string_with_of_z () =
    List.iter
      (fun x ->
        assert (
          Bls12_381.Fr.eq
            (Bls12_381.Fr.of_string x)
            (Bls12_381.Fr.of_z (Z.of_string x)) ))
      test_vectors

  let test_of_string_to_string_consistency () =
    List.iter
      (fun x ->
        assert (
          String.equal (Bls12_381.Fr.to_string (Bls12_381.Fr.of_string x)) x ))
      test_vectors

  let get_tests () =
    let open Alcotest in
    ( "String representation",
      [ test_case "one" `Quick test_to_string_one;
        test_case
          "consistency of_string with of_z with test vectors"
          `Quick
          test_of_string_with_of_z;
        test_case
          "consistency of_string to_string with test vectors"
          `Quick
          test_of_string_to_string_consistency;
        test_case "zero" `Quick test_to_string_zero ] )
end

module ZRepresentation = struct
  let test_of_z_zero () =
    assert (Bls12_381.Fr.eq (Bls12_381.Fr.zero ()) (Bls12_381.Fr.of_z Z.zero))

  let test_of_z_one () =
    assert (
      Bls12_381.Fr.eq
        (Bls12_381.Fr.one ())
        (Bls12_381.Fr.of_z (Z.of_string "1")) )

  let test_random_of_z_and_to_z () =
    let x = Bls12_381.Fr.random () in
    assert (Bls12_381.Fr.eq x (Bls12_381.Fr.of_z (Bls12_381.Fr.to_z x)))

  let test_random_to_z_and_of_z () =
    let x = Z.of_int (Random.int 2_000_000) in
    assert (Z.equal (Bls12_381.Fr.to_z (Bls12_381.Fr.of_z x)) x)

  let test_vectors_to_z_and_of_z () =
    let test_vectors = List.map Z.of_string test_vectors in
    List.iter
      (fun x -> assert (Z.equal (Bls12_381.Fr.to_z (Bls12_381.Fr.of_z x)) x))
      test_vectors

  let get_tests () =
    let open Alcotest in
    ( "Z representation",
      [ test_case "one" `Quick test_of_z_one;
        test_case "zero" `Quick test_of_z_zero;
        test_case
          "of z and to z with random small numbers"
          `Quick
          (repeat 1000 test_random_of_z_and_to_z);
        test_case
          "to z and of z with test vectors"
          `Quick
          test_vectors_to_z_and_of_z;
        test_case
          "to z and of z with random small numbers"
          `Quick
          (repeat 1000 test_random_to_z_and_of_z) ] )
end

module TestVector = struct
  let test_inverse () =
    let test_vectors =
      [ ( "5241434266765085153989819426158356963249585137477420674959011812945457865191",
          "10839440052692226066497714164180551800338639216929046788248680350103009908352"
        );
        ( "45771516566988367809715142190959127910391288669516577059039340716912455457131",
          "45609475631078884634858595528211458305369692448866344559573507066772305338186"
        );
        ( "12909915968096385929046240252673624834885730199746273136167032454235900707423",
          "11000310335493461593980032382804784919007817741315871286620011674413549793814"
        );
        ( "9906806778085203695146840231942453635945512651510460213691437498308396392030",
          "14376170892131209521313997949250266279614396523892055155196474364730307649110"
        );
        ( "20451006147593515828371694915490427948041026610654337997907355913265840025855",
          "9251674366848220983783993301665718813823734287374642487691950418950023775049"
        );
        ( "22753274685202779061111872324861161292260930710591061598808549358079414450472",
          "5879182491359474138365930955028927605587956455972550635628359324770111549635"
        );
        ( "12823588949385074189879212809942339506958509313775057573450243545256259992541",
          "37176703988340956294235799427206509384158992510189606907136259793202107500314"
        ) ]
    in
    List.iter
      (fun (e, i) ->
        assert (
          Bls12_381.Fr.eq
            (Bls12_381.Fr.inverse (Bls12_381.Fr.of_string e))
            (Bls12_381.Fr.of_string i) ))
      test_vectors ;
    List.iter
      (fun (e, i) ->
        assert (
          Bls12_381.Fr.eq
            (Bls12_381.Fr.inverse (Bls12_381.Fr.of_string i))
            (Bls12_381.Fr.of_string e) ))
      test_vectors

  let get_tests () =
    let open Alcotest in
    ("Test vectors", [test_case "inverse" `Quick test_inverse])
end

let () =
  let open Alcotest in
  run
    "Fr"
    [ IsZero.get_tests ();
      ValueGeneration.get_tests ();
      Equality.get_tests ();
      FieldProperties.get_tests ();
      TestVector.get_tests ();
      StringRepresentation.get_tests () ]
