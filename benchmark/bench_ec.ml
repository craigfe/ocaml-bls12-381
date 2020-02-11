open Core_bench.Std

module ECBenchmark (G : Bls12_381.Elliptic_curve_sig.T) = struct
  let g1 = G.random ()

  let g2 = G.random ()

  let generate_random_element () = ignore @@ G.random ()

  let generate_addition () = G.add g1 g2

  let generate_opposite_of_pregenerated_random_element () =
    ignore @@ G.negate g1

  let generate_opposite_of_zero () = ignore @@ G.negate (G.zero ())

  let get_benches ec_name =
    [ (* Bench.Test.create ~name:(Printf.sprintf "%s addition" ec_name) generate_addition; *)
      (* Bench.Test.create ~name:(Printf.sprintf "%s random" ec_name) generate_random_element; *)
      Bench.Test.create ~name:(Printf.sprintf "%s opposite of pregenerated random element" ec_name) generate_opposite_of_pregenerated_random_element ;
      (* Bench.Test.create
       *   ~name:(Printf.sprintf "%s opposite of zero" ec_name)
       *   generate_opposite_of_zero *)
]
end

module BenchmarkG1Uncompressed = ECBenchmark (Bls12_381.G1.Uncompressed)
module BenchmarkG1Compressed = ECBenchmark (Bls12_381.G1.Compressed)
module BenchmarkG2Uncompressed = ECBenchmark (Bls12_381.G2.Uncompressed)
module BenchmarkG2Compressed = ECBenchmark (Bls12_381.G2.Compressed)

let () =
  let commands =
    List.concat
      [ BenchmarkG1Uncompressed.get_benches "G1 Uncompressed"
        (* BenchmarkG1Uncompressed.get_benches "G1 Compressed"; *)
        (* BenchmarkG1Uncompressed.get_benches "G2 Uncompressed"; *)
        (* BenchmarkG1Uncompressed.get_benches "G2 Compressed"; *) ]
  in
  Core.Command.run (Bench.make_command commands)
