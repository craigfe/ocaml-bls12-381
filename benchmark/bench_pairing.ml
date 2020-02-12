open Core_bench


let g1 = Bls12_381.G1.Uncompressed.random ()
let g2 = Bls12_381.G2.Uncompressed.random ()

let compute_pairing_on_pregenerated_random_element () =
  Bls12_381.Pairing.pairing g1 g2

let () =
  Core.Command.run (Bench.make_command [
    Bench.Test.create ~name:"Pairing on pregenerated random element" compute_pairing_on_pregenerated_random_element
  ])
