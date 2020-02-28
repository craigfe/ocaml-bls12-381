## Benchmark

This directory contains benchmarks for G1, G2, Fr, Fq12 and the pairing function.
The benchmarks are generic (using functors), and can be used for any elliptic
curves or finite fields. `Core_bench` is used for the benchmark tool.

For the elliptic curves (resp. finite fields), a functor `ECBenchmark` (resp.
`FFBenchmark`) is provided in `bench_ec.ml` (resp. `bench_ff.ml`).

Benchmarking a finite field or an elliptic curve implementation is relatively simple using these functors:

```ocaml
module BenchmarkG1Uncompressed = ECBenchmark (Bls12_381.G1.Uncompressed)
let () =
  let commands = BenchmarkG1Uncompressed.get_benches "G1 Uncompressed" in
  Core.Command.run (Bench.make_command commands)
```

### Run the benches

```shell
opam install core_bench
dune exec benchmark/bench_ec.exe
dune exec benchmark/bench_ff.exe
dune exec benchmark/bench_pairing.exe
```

### Benchmarks results

The following results have been run on a machine with
- CPU: Intel(R) Core(TM** i7-8565U CPU @ 1.80GHz
- RAM: 16Go

and with the commands given above.

**!!Note benchmarking depends on the machine and may differ between execution.
Sometimes, we experienced a difference of 10%. For instance, we have experienced
a time/run of 2.78ms for the pairing!!**

#### Elliptic curves

| Name                                                                                    | Time/Run (Rust 1.40.0, OCaml 4.07.1) | mWd/Run | Percentage |
|-----------------------------------------------------------------------------------------|--------------------------------------|---------|------------|
| G1 Uncompressed compute addition pregenerated random element                            | 417_023.31ns                         | 14.00w  |     11.21% |
| G1 Uncompressed random generation                                                       | 160_355.11ns                         | 14.00w  |      4.31% |
| G1 Uncompressed zero generation                                                         | 35.20ns                              | 14.00w  |            |
| G1 Uncompressed one generation                                                          | 132.06ns                             | 14.00w  |            |
| G1 Uncompressed check if zero on pregenerated random                                    | 206_903.33ns                         |         |      5.56% |
| G1 Uncompressed check if zero on pregenerated one                                       | 201_565.51ns                         |         |      5.42% |
| G1 Uncompressed check if zero on pregenerated zero                                      | 1_221.27ns                           |         |      0.03% |
| G1 Uncompressed check equality on random                                                | 408_056.76ns                         |         |     10.97% |
| G1 Uncompressed check equality on one and random                                        | 411_054.42ns                         |         |     11.05% |
| G1 Uncompressed check equality on zero and random                                       | 203_054.28ns                         |         |      5.46% |
| G1 Uncompressed check equality on same element                                          | 400_647.64ns                         |         |     10.77% |
| G1 Uncompressed compute scalar multiplication on pregenerated random element and scalar | 441_382.90ns                         | 14.00w  |     11.86% |
| G1 Uncompressed check if zero on pregenerated zero                                      | 1_153.66ns                           |         |      0.03% |
| G1 Uncompressed opposite of pregenerated random element                                 | 201_767.53ns                         | 14.00w  |      5.42% |
| G1 Uncompressed opposite of zero                                                        | 1_128.83ns                           | 14.00w  |      0.03% |
| G1 Uncompressed opposite of one                                                         | 201_023.40ns                         | 14.00w  |      5.40% |
| G1 Compressed compute addition pregenerated random element                              | 1_139_271.39ns                       | 50.00w  |     30.61% |
| G1 Compressed random generation                                                         | 369_957.99ns                         | 22.00w  |      9.94% |
| G1 Compressed zero generation                                                           | 1_165.56ns                           | 22.00w  |      0.03% |
| G1 Compressed one generation                                                            | 202_126.48ns                         | 22.00w  |      5.43% |
| G1 Compressed check if zero on pregenerated random                                      | 431_522.85ns                         | 14.00w  |     11.60% |
| G1 Compressed check if zero on pregenerated one                                         | 433_185.13ns                         | 14.00w  |     11.64% |
| G1 Compressed check if zero on pregenerated zero                                        | 2_227.23ns                           | 14.00w  |      0.06% |
| G1 Compressed check equality on random                                                  | 878_173.92ns                         | 28.00w  |     23.60% |
| G1 Compressed check equality on one and random                                          | 904_645.11ns                         | 28.00w  |     24.31% |
| G1 Compressed check equality on zero and random                                         | 430_728.83ns                         | 28.00w  |     11.57% |
| G1 Compressed check equality on same element                                            | 862_415.17ns                         | 28.00w  |     23.17% |
| G1 Compressed compute scalar multiplication on pregenerated random element and scalar   | 947_458.04ns                         | 36.00w  |     25.46% |
| G1 Compressed check if zero on pregenerated zero                                        | 2_228.00ns                           | 14.00w  |      0.06% |
| G1 Compressed opposite of pregenerated random element                                   | 638_236.89ns                         | 36.00w  |     17.15% |
| G1 Compressed opposite of zero                                                          | 3_396.97ns                           | 36.00w  |      0.09% |
| G1 Compressed opposite of one                                                           | 641_294.08ns                         | 36.00w  |     17.23% |
| G2 Uncompressed compute addition pregenerated random element                            | 1_427_225.06ns                       | 26.00w  |     38.35% |
| G2 Uncompressed random generation                                                       | 1_586_625.22ns                       | 26.00w  |     42.63% |
| G2 Uncompressed zero generation                                                         | 58.10ns                              | 26.00w  |            |
| G2 Uncompressed one generation                                                          | 232.63ns                             | 26.00w  |            |
| G2 Uncompressed check if zero on pregenerated random                                    | 657_343.93ns                         |         |     17.66% |
| G2 Uncompressed check if zero on pregenerated one                                       | 654_077.10ns                         |         |     17.58% |
| G2 Uncompressed check if zero on pregenerated zero                                      | 1_355.71ns                           |         |      0.04% |
| G2 Uncompressed check equality on random                                                | 1_323_136.55ns                       |         |     35.55% |
| G2 Uncompressed check equality on one and random                                        | 1_329_484.57ns                       |         |     35.73% |
| G2 Uncompressed check equality on zero and random                                       | 663_456.28ns                         |         |     17.83% |
| G2 Uncompressed check equality on same element                                          | 1_321_606.37ns                       |         |     35.51% |
| G2 Uncompressed compute scalar multiplication on pregenerated random element and scalar | 1_496_910.22ns                       | 26.00w  |     40.22% |
| G2 Uncompressed check if zero on pregenerated zero                                      | 1_354.07ns                           |         |      0.04% |
| G2 Uncompressed opposite of pregenerated random element                                 | 700_405.34ns                         | 26.00w  |     18.82% |
| G2 Uncompressed opposite of zero                                                        | 1_382.32ns                           | 26.00w  |      0.04% |
| G2 Uncompressed opposite of one                                                         | 653_720.57ns                         | 26.00w  |     17.57% |
| G2 Compressed compute addition pregenerated random element                              | 3_721_433.97ns                       | 92.00w  |    100.00% |
| G2 Compressed random generation                                                         | 2_357_802.90ns                       | 40.00w  |     63.36% |
| G2 Compressed zero generation                                                           | 1_439.77ns                           | 40.00w  |      0.04% |
| G2 Compressed one generation                                                            | 655_127.04ns                         | 40.00w  |     17.60% |
| G2 Compressed check if zero on pregenerated random                                      | 1_519_940.33ns                       | 26.00w  |     40.84% |
| G2 Compressed check if zero on pregenerated one                                         | 1_556_797.50ns                       | 26.00w  |     41.83% |
| G2 Compressed check if zero on pregenerated zero                                        | 2_652.95ns                           | 26.00w  |      0.07% |
| G2 Compressed check equality on random                                                  | 3_035_764.46ns                       | 52.00w  |     81.58% |
| G2 Compressed check equality on one and random                                          | 3_056_771.27ns                       | 52.00w  |     82.14% |
| G2 Compressed check equality on zero and random                                         | 1_630_587.18ns                       | 52.00w  |     43.82% |
| G2 Compressed check equality on same element                                            | 3_021_525.53ns                       | 52.00w  |     81.19% |
| G2 Compressed compute scalar multiplication on pregenerated random element and scalar   | 2_966_320.57ns                       | 66.00w  |     79.71% |
| G2 Compressed check if zero on pregenerated zero                                        | 2_684.28ns                           | 26.00w  |      0.07% |
| G2 Compressed opposite of pregenerated random element                                   | 2_292_456.49ns                       | 66.00w  |     61.60% |
| G2 Compressed opposite of zero                                                          | 4_260.15ns                           | 66.00w  |      0.11% |
| G2 Compressed opposite of one                                                           | 2_217_495.04ns                       | 66.00w  |     59.59% |

#### Finite field

| Name                                                    | Time/Run (Rust 1.40.0, OCaml 4.07.1) | mWd/Run | Percentage |
|---------------------------------------------------------|--------------------------------------|---------|------------|
| Fr compute addition pregenerated random element         | 129.94ns                             | 6.00w   |      0.79% |
| Fr random generation                                    | 69.24ns                              | 6.00w   |      0.42% |
| Fr zero generation                                      | 40.96ns                              | 6.00w   |      0.25% |
| Fr one generation                                       | 33.38ns                              | 6.00w   |      0.20% |
| Fr check if zero on pregenerated random                 | 41.71ns                              |         |      0.25% |
| Fr check if zero on pregenerated one                    | 41.56ns                              |         |      0.25% |
| Fr check if zero on pregenerated zero                   | 43.14ns                              |         |      0.26% |
| Fr check if one on pregenerated random                  | 43.89ns                              |         |      0.27% |
| Fr check if one on pregenerated one                     | 44.04ns                              |         |      0.27% |
| Fr check if one on pregenerated zero                    | 43.81ns                              |         |      0.27% |
| Fr compute addition on pregenerate random               | 119.29ns                             | 6.00w   |      0.73% |
| Fr compute multiplication on pregenerate random         | 165.85ns                             | 6.00w   |      1.01% |
| Fr compute square on pregenerate random                 | 103.47ns                             | 6.00w   |      0.63% |
| Fr compute double on pregenerate random                 | 83.34ns                              | 6.00w   |      0.51% |
| Fr compute equality on random                           | 81.68ns                              |         |      0.50% |
| Fr compute equality on same element                     | 80.71ns                              |         |      0.49% |
| Fr compute opposite of pregenerated random element      | 85.49ns                              | 6.00w   |      0.52% |
| Fr compute opposite of pregenerated one element         | 84.49ns                              | 6.00w   |      0.51% |
| Fr compute opposite of pregenerated zero element        | 81.65ns                              | 6.00w   |      0.50% |
| Fr compute inverse of pregenerated random element       | 2_621.53ns                           | 6.00w   |     15.94% |
| Fr compute inverse of pregenerated one element          | 2_404.37ns                           | 6.00w   |     14.62% |
| Fr compute inverse opt of pregenerated random element   | 2_492.41ns                           | 8.00w   |     15.16% |
| Fr compute inverse opt of pregenerated one element      | 2_462.46ns                           | 8.00w   |     14.98% |
| Fr compute inverse opt of pregenerated zero element     | 43.72ns                              |         |      0.27% |
| Fq12 compute addition pregenerated random element       | 2_364.19ns                           | 74.00w  |     14.38% |
| Fq12 random generation                                  | 1_167.39ns                           | 74.00w  |      7.10% |
| Fq12 zero generation                                    | 618.07ns                             | 74.00w  |      3.76% |
| Fq12 one generation                                     | 622.53ns                             | 74.00w  |      3.79% |
| Fq12 check if zero on pregenerated random               | 817.53ns                             |         |      4.97% |
| Fq12 check if zero on pregenerated one                  | 789.68ns                             |         |      4.80% |
| Fq12 check if zero on pregenerated zero                 | 799.72ns                             |         |      4.86% |
| Fq12 check if one on pregenerated random                | 888.10ns                             |         |      5.40% |
| Fq12 check if one on pregenerated one                   | 888.75ns                             |         |      5.40% |
| Fq12 check if one on pregenerated zero                  | 828.30ns                             |         |      5.04% |
| Fq12 compute addition on pregenerate random             | 2_591.27ns                           | 74.00w  |     15.76% |
| Fq12 compute multiplication on pregenerate random       | 10_111.69ns                          | 74.00w  |     61.49% |
| Fq12 compute square on pregenerate random               | 4_304.30ns                           | 74.00w  |     26.18% |
| Fq12 compute double on pregenerate random               | 1_570.81ns                           | 74.00w  |      9.55% |
| Fq12 compute equality on random                         | 1_559.72ns                           |         |      9.49% |
| Fq12 compute equality on same element                   | 1_622.36ns                           |         |      9.87% |
| Fq12 compute opposite of pregenerated random element    | 1_599.65ns                           | 74.00w  |      9.73% |
| Fq12 compute opposite of pregenerated one element       | 1_536.35ns                           | 74.00w  |      9.34% |
| Fq12 compute opposite of pregenerated zero element      | 1_520.81ns                           | 74.00w  |      9.25% |
| Fq12 compute inverse of pregenerated random element     | 15_882.21ns                          | 74.00w  |     96.59% |
| Fq12 compute inverse of pregenerated one element        | 15_079.48ns                          | 74.00w  |     91.71% |
| Fq12 compute inverse opt of pregenerated random element | 15_682.97ns                          | 76.00w  |     95.38% |
| Fq12 compute inverse opt of pregenerated one element    | 16_443.32ns                          | 76.00w  |    100.00% |
| Fq12 compute inverse opt of pregenerated zero element   | 828.00ns                             |         |      5.04% |

#### Pairing

| Name                                                                                                       | Time/Run (Rust 1.40.0, OCaml 4.07.1) | mWd/Run | mjWd/Run | Prom/Run | Percentage |
|------------------------------------------------------------------------------------------------------------|--------------------------------------|---------|----------|----------|------------|
| Pairing on pregenerated uncompressed random elements                                                       | 2.96ms                               | 74.00w  |          |          |     38.43% |
| Miller loop on pregenerated uncompressed random elements                                                   | 1.58ms                               | 74.00w  |          |          |     20.54% |
| Miller loop on three pregenerated couples of uncompressed random elements                                  | 6.20ms                               | 592.00w | 0.25w    | 0.25w    |     80.53% |
| Miller loop on three pregenerated couples of uncompressed random elements followed by final exponentiation | 7.69ms                               | 668.00w | 0.13w    | 0.13w    |    100.00% |
| Final exponentiation on pregenerated random element                                                        | 1.41ms                               | 76.00w  |          |          |     18.28% |
