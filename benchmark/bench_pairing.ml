open Core_bench

let g1 = Bls12_381.G1.Uncompressed.random ()

let g2 = Bls12_381.G2.Uncompressed.random ()

let three_g1_and_g2 =
  [ (Bls12_381.G1.Uncompressed.random (), Bls12_381.G2.Uncompressed.random ());
    (Bls12_381.G1.Uncompressed.random (), Bls12_381.G2.Uncompressed.random ());
    (Bls12_381.G1.Uncompressed.random (), Bls12_381.G2.Uncompressed.random ())
  ]

let a = Bls12_381.Fq12.random ()

let compute_pairing_on_pregenerated_random_elements () =
  Bls12_381.Pairing.pairing g1 g2

let compute_miller_loop_on_pregenerated_random_elements () =
  Bls12_381.Pairing.miller_loop_simple g1 g2

let compute_final_exponentiation_on_pregenerated_random_element () =
  Bls12_381.Pairing.final_exponentiation a

let compute_miller_loop_on_three_pregenerated_couple_of_uncompressed_random_elements
    () =
  Bls12_381.Pairing.miller_loop three_g1_and_g2

let compute_miller_loop_on_three_pregenerated_couple_of_uncompressed_random_elements_followed_by_final_exponentiation
    () =
  Bls12_381.Pairing.final_exponentiation
  @@ Bls12_381.Pairing.miller_loop three_g1_and_g2

let () =
  Core.Command.run
    (Bench.make_command
       [ Bench.Test.create
           ~name:"Pairing on pregenerated uncompressed random elements"
           compute_pairing_on_pregenerated_random_elements;
         Bench.Test.create
           ~name:"Miller loop on pregenerated uncompressed random elements"
           compute_miller_loop_on_pregenerated_random_elements;
         Bench.Test.create
           ~name:
             "Miller loop on three pregenerated couples of uncompressed random elements"
           compute_miller_loop_on_three_pregenerated_couple_of_uncompressed_random_elements;
         Bench.Test.create
           ~name:
             "Miller loop on three pregenerated couples of uncompressed random elements followed by final exponentiation"
           compute_miller_loop_on_three_pregenerated_couple_of_uncompressed_random_elements_followed_by_final_exponentiation;
         Bench.Test.create
           ~name:"Final exponentiation on pregenerated random element"
           compute_final_exponentiation_on_pregenerated_random_element ])
