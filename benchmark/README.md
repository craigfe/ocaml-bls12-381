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
A benchmark of the Rust code (not including the conversion between C array and the Rust representation) is algo given as a reference.
It may happen the Rust code looks slower than the binding, the reason being the
benchmark strategies are different between Rust and Core Bench in OCaml.

**!!Note benchmarking depends on the machine and may differ between execution.
Sometimes, we experienced a difference of 10%. For instance, we have experienced
a time/run of 2.78ms for the pairing!!**

#### Elliptic curves

| Name                                                                                    | Rust 1.40.0 | Rust 1.40.0, OCaml 4.07.1 | mWd/Run |
|-----------------------------------------------------------------------------------------|-------------|---------------------------|---------|
| G1 Uncompressed compute addition pregenerated random element                            | 410_101ns   | 417_023.31ns              | 14.00w  |
| G1 Uncompressed random generation                                                       | 157_111ns   | 160_355.11ns              | 14.00w  |
| G1 Uncompressed zero generation                                                         | 25ns        | 35.20ns                   | 14.00w  |
| G1 Uncompressed one generation                                                          | 106ns       | 132.06ns                  | 14.00w  |
| G1 Uncompressed check if zero on pregenerated random                                    | 198_220ns   | 206_903.33ns              |         |
| G1 Uncompressed check if zero on pregenerated one                                       | 197_494ns   | 201_565.51ns              |         |
| G1 Uncompressed check if zero on pregenerated zero                                      | 1_010ns     | 1_221.27ns                |         |
| G1 Uncompressed check equality on random                                                | 402_460     | 408_056.76ns              |         |
| G1 Uncompressed check equality on one and random                                        | 400_360ns   | 411_054.42ns              |         |
| G1 Uncompressed check equality on zero and random                                       | 198_272ns   | 203_054.28ns              |         |
| G1 Uncompressed check equality on same element                                          |             | 400_647.64ns              |         |
| G1 Uncompressed compute scalar multiplication on pregenerated random element and scalar | 449_115ns   | 441_382.90ns              | 14.00w  |
| G1 Uncompressed opposite of pregenerated random element                                 | 196_701ns   | 201_767.53ns              | 14.00w  |
| G1 Uncompressed opposite of zero                                                        | 1036ns      | 1_128.83ns                | 14.00w  |
| G1 Uncompressed opposite of one                                                         | 197_684ns   | 201_023.40ns              | 14.00w  |
| G1 Compressed compute addition pregenerated random element                              | 467,136ns   | 462_523.04ns              | 8.00w   |
| G1 Compressed random generation                                                         |             | 155_109.37ns              | 8.00w   |
| G1 Compressed zero generation                                                           |             | 36.09ns                   | 8.00w   |
| G1 Compressed one generation                                                            |             | 139.05ns                  | 8.00w   |
| G1 Compressed check if zero on pregenerated random                                      | 224_174ns   | 223_785.68ns              |         |
| G1 Compressed check if zero on pregenerated one                                         | 230_364ms   | 220_527.60ns              |         |
| G1 Compressed check if zero on pregenerated zero                                        | 994ns       | 1_797.12ns                |         |
| G1 Compressed check equality on random                                                  | 456_978ns   | 452_046.13ns              |         |
| G1 Compressed check equality on one and random                                          | 457_383ns   | 451_769.33ns              |         |
| G1 Compressed check equality on zero and random                                         | 225_693ns   | 231_906.31ns              |         |
| G1 Compressed check equality on same element                                            |             | 441_550.86ns              |         |
| G1 Compressed compute scalar multiplication on pregenerated random element and scalar   | 464_502ns   | 457_372.34ns              | 8.00w   |
| G1 Compressed opposite of pregenerated random element                                   | 224_911ns   | 221_640.37ns              | 8.00w   |
| G1 Compressed opposite of zero                                                          | 1,009ns     | 1_831.02ns                | 8.00w   |
| G1 Compressed opposite of one                                                           | 224_293ns   | 225_160.33ns              | 8.00w   |
| G2 Uncompressed compute addition pregenerated random element                            | 1_304_136ns | 1_427_225.06ns            | 26.00w  |
| G2 Uncompressed random generation                                                       | 1_824_750ns | 1_586_625.22ns            | 26.00w  |
| G2 Uncompressed zero generation                                                         | 42ns        | 58.10ns                   | 26.00w  |
| G2 Uncompressed one generation                                                          | 211ns       | 232.63ns                  | 26.00w  |
| G2 Uncompressed check if zero on pregenerated random                                    | 691_823ns   | 657_343.93ns              |         |
| G2 Uncompressed check if zero on pregenerated one                                       | 739_643ns   | 654_077.10ns              |         |
| G2 Uncompressed check if zero on pregenerated zero                                      | 1_358ns     | 1_355.71ns                |         |
| G2 Uncompressed check equality on random                                                | 1_473_690ns | 1_323_136.55ns            |         |
| G2 Uncompressed check equality on one and random                                        | 1_396_319ns | 1_329_484.57ns            |         |
| G2 Uncompressed check equality on zero and random                                       | 716_430ns   | 663_456.28ns              |         |
| G2 Uncompressed check equality on same element                                          |             | 1_321_606.37ns            |         |
| G2 Uncompressed compute scalar multiplication on pregenerated random element and scalar | 1_533_604ns | 1_496_910.22ns            | 26.00w  |
| G2 Uncompressed opposite of pregenerated random element                                 | 770_652ns   | 700_405.34ns              | 26.00w  |
| G2 Uncompressed opposite of zero                                                        | 1_456ns     | 1_382.32ns                | 26.00w  |
| G2 Uncompressed opposite of one                                                         | 723_777ns   | 653_720.57ns              | 26.00w  |
| G2 Compressed compute addition pregenerated random element                              | 1_701_145ns | 1_846_531.95ns            | 14.00w  |
| G2 Compressed random generation                                                         |             | 1_564_921.86ns            | 14.00w  |
| G2 Compressed zero generation                                                           |             | 51.65ns                   | 14.00w  |
| G2 Compressed one generation                                                            |             | 206.39ns                  | 14.00w  |
| G2 Compressed check if zero on pregenerated random                                      | 835_273ns   | 861_050.95ns              |         |
| G2 Compressed check if zero on pregenerated one                                         | 836_098ns   | 847_608.74ns              |         |
| G2 Compressed check if zero on pregenerated zero                                        | 1_220ns     | 3_075.86ns                |         |
| G2 Compressed check equality on random                                                  | 1,681_466ns | 1_685_200.77ns            |         |
| G2 Compressed check equality on one and random                                          | 1_720_012ns | 1_697_912.38ns            |         |
| G2 Compressed check equality on zero and random                                         | 225_693ns   | 869_173.52ns              |         |
| G2 Compressed check equality on same element                                            |             | 1_732_638.13ns            |         |
| G2 Compressed compute scalar multiplication on pregenerated random element and scalar   | 1_597_721ns | 1_645_250.71ns            | 14.00w  |
| G2 Compressed opposite of pregenerated random element                                   | 838_832ns   | 877_347.02ns              | 14.00w  |
| G2 Compressed opposite of zero                                                          | 1236ns      | 3_112.50ns                | 14.00w  |
| G2 Compressed opposite of one                                                           | 838_266ns   | 864_949.32ns              | 14.00w  |

#### Finite field

| Name                                                    | Rust 1.40.0 | Rust 1.40.0, OCaml 4.07.1 | mWd/Run |
|---------------------------------------------------------|-------------|---------------------------|---------|
| Fr compute addition pregenerated random element         |             | 129.94ns                  | 6.00w   |
| Fr random generation                                    |             | 69.24ns                   | 6.00w   |
| Fr zero generation                                      |             | 40.96ns                   | 6.00w   |
| Fr one generation                                       |             | 33.38ns                   | 6.00w   |
| Fr check if zero on pregenerated random                 |             | 41.71ns                   |         |
| Fr check if zero on pregenerated one                    |             | 41.56ns                   |         |
| Fr check if zero on pregenerated zero                   |             | 43.14ns                   |         |
| Fr check if one on pregenerated random                  |             | 43.89ns                   |         |
| Fr check if one on pregenerated one                     |             | 44.04ns                   |         |
| Fr check if one on pregenerated zero                    |             | 43.81ns                   |         |
| Fr compute addition on pregenerate random               |             | 119.29ns                  | 6.00w   |
| Fr compute multiplication on pregenerate random         |             | 165.85ns                  | 6.00w   |
| Fr compute square on pregenerate random                 |             | 103.47ns                  | 6.00w   |
| Fr compute double on pregenerate random                 |             | 83.34ns                   | 6.00w   |
| Fr compute equality on random                           |             | 81.68ns                   |         |
| Fr compute equality on same element                     |             | 80.71ns                   |         |
| Fr compute opposite of pregenerated random element      |             | 85.49ns                   | 6.00w   |
| Fr compute opposite of pregenerated one element         |             | 84.49ns                   | 6.00w   |
| Fr compute opposite of pregenerated zero element        |             | 81.65ns                   | 6.00w   |
| Fr compute inverse of pregenerated random element       |             | 2_621.53ns                | 6.00w   |
| Fr compute inverse of pregenerated one element          |             | 2_404.37ns                | 6.00w   |
| Fr compute inverse opt of pregenerated random element   |             | 2_492.41ns                | 8.00w   |
| Fr compute inverse opt of pregenerated one element      |             | 2_462.46ns                | 8.00w   |
| Fr compute inverse opt of pregenerated zero element     |             | 43.72ns                   |         |
| Fq12 compute addition pregenerated random element       |             | 2_364.19ns                | 74.00w  |
| Fq12 random generation                                  |             | 1_167.39ns                | 74.00w  |
| Fq12 zero generation                                    |             | 618.07ns                  | 74.00w  |
| Fq12 one generation                                     |             | 622.53ns                  | 74.00w  |
| Fq12 check if zero on pregenerated random               |             | 817.53ns                  |         |
| Fq12 check if zero on pregenerated one                  |             | 789.68ns                  |         |
| Fq12 check if zero on pregenerated zero                 |             | 799.72ns                  |         |
| Fq12 check if one on pregenerated random                |             | 888.10ns                  |         |
| Fq12 check if one on pregenerated one                   |             | 888.75ns                  |         |
| Fq12 check if one on pregenerated zero                  |             | 828.30ns                  |         |
| Fq12 compute addition on pregenerate random             |             | 2_591.27ns                | 74.00w  |
| Fq12 compute multiplication on pregenerate random       |             | 10_111.69ns               | 74.00w  |
| Fq12 compute square on pregenerate random               |             | 4_304.30ns                | 74.00w  |
| Fq12 compute double on pregenerate random               |             | 1_570.81ns                | 74.00w  |
| Fq12 compute equality on random                         |             | 1_559.72ns                |         |
| Fq12 compute equality on same element                   |             | 1_622.36ns                |         |
| Fq12 compute opposite of pregenerated random element    |             | 1_599.65ns                | 74.00w  |
| Fq12 compute opposite of pregenerated one element       |             | 1_536.35ns                | 74.00w  |
| Fq12 compute opposite of pregenerated zero element      |             | 1_520.81ns                | 74.00w  |
| Fq12 compute inverse of pregenerated random element     |             | 15_882.21ns               | 74.00w  |
| Fq12 compute inverse of pregenerated one element        |             | 15_079.48ns               | 74.00w  |
| Fq12 compute inverse opt of pregenerated random element |             | 15_682.97ns               | 76.00w  |
| Fq12 compute inverse opt of pregenerated one element    |             | 16_443.32ns               | 76.00w  |
| Fq12 compute inverse opt of pregenerated zero element   |             | 828.00ns                  |         |

#### Pairing

| Name                                                                                                       | Rust 1.40.0 | Rust 1.40.0, OCaml 4.07.1 | mWd/Run | mjWd/Run | Prom/Run |
|------------------------------------------------------------------------------------------------------------|-------------|---------------------------|---------|----------|----------|
| Pairing on pregenerated uncompressed random elements                                                       |             | 2.96ms                    | 74.00w  |          |          |
| Miller loop on pregenerated uncompressed random elements                                                   |             | 1.58ms                    | 74.00w  |          |          |
| Miller loop on three pregenerated couples of uncompressed random elements                                  |             | 6.20ms                    | 592.00w | 0.25w    | 0.25w    |
| Miller loop on three pregenerated couples of uncompressed random elements followed by final exponentiation |             | 7.69ms                    | 668.00w | 0.13w    | 0.13w    |
| Final exponentiation on pregenerated random element                                                        |             | 1.41ms                    | 76.00w  |          |          |
