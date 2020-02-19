# THIS IS A WIP

## Install

1. Setup environment
```
opam switch create ./ 4.07.1
eval $(opam env)
```

2. Install Rust dependencies


```
# static library will be installed here
mkdir ${OPAM_SWITCH_PREFIX}/lib/librustc-bls12-381/
git clone https://gitlab.com/dannywillems/rustc-bls12-381 /tmp/rustc-bls12-381
cd /tmp/rustc-bls12-381
cargo build
```

Then copy `target/debug/librustc_bls12_381.a` in `${OPAM_SWITCH_PREFIX}/lib/librustc-bls12-381`:
```
cp /tmp/rustc-bls12-381/target/debug/librustc_bls12_381.a ${OPAM_SWITCH_PREFIX}/lib/librustc-bls12-381
```

3. build

```
dune build
```

4. Play with utop

```
opam install utop
dune utop
```

## Run tests

```
dune build @install
opam install alcotest
dune runtest
```

## Run the benchmarks

**USE THE RELEASE VERSION OF THE RUST LIBRARY TO GET PRODUCTION BENCHMARKS (cargo build --release)**

```
opam install core_bench
dune exec benchmark/bench_ec.exe
dune exec benchmark/bench_ff.exe
dune exec benchmark/bench_pairing.exe
```

## TODO

- Use integer instead of void to handle errors in the C stubs


## Documentation

- Use `dune build @doc` to generate the API documentation.
