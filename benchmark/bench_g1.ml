open Core_bench.Std

module ECBenchmark(G: Bls12_381.Elliptic_curve_sig.T) = struct
  let g1 = G.random ()
  let g2 = G.random ()

  let generate_random_element () =
    ignore @@ G.random ()

  let generate_addition () =
    G.add g1 g2

  let generate_opposite () =
    ignore @@ G.negate g1
end

module BenchmarkG1Uncompressed = ECBenchmark(Bls12_381.G1.Uncompressed)
module BenchmarkG1Compressed = ECBenchmark(Bls12_381.G1.Compressed)

let () =
  Core.Command.run (Bench.make_command [
    (* Bench.Test.create ~name:"G1 Uncompressed addition" BenchmarkG1Uncompressed.generate_addition ; *)
    Bench.Test.create ~name:"G1 Uncompressed opposite" BenchmarkG1Uncompressed.generate_opposite ;
    (* Bench.Test.create ~name:"G1 Uncompressed random generation" BenchmarkG1Uncompressed.generate_random_element ; *)
    (* Bench.Test.create ~name:"G1 Compressed addition" BenchmarkG1Compressed.generate_addition ; *)
    (* Bench.Test.create ~name:"G1 Compressed opposite" BenchmarkG1Compressed.generate_opposite ; *)
    (* Bench.Test.create ~name:"G1 Compressed random generation" BenchmarkG1Compressed.generate_random_element ; *)
  ])
