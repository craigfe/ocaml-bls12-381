# OCaml implementation of BLS12-381


## Install

1. Setup environment
```
opam switch create ./ 4.09.1 --deps-only
eval $(opam env)
```

2. Install Rust dependencies and install the library


```
./build_deps.sh
opam install . -y
```

3. Play with utop

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

## How to use in my project

If you are developing a library using `bls12-381`, you only need to add `bls12-381` in the dependency list.
However, if you are writing a binary, three packages are relevant:
- `bls12-381-unix`: to be used for UNIX
- `bls12-381-js`: to be used to target JavaScript. It does rely on the node
  packages listed
  [here](https://gitlab.com/dannywillems/rustc-bls12-381/-/packages), version >=
  0.8.1, and suppose this module is loaded before in the global namespace under
  the name `_RUSTC_BLS12_381`. See `test/js/browser/` for an example. You need
  to use the appropriate package depending on the platform you target (Node or a
  bundler for the browser). For instance, if you target Node (resp. a bundler
  like webpack for a browser usage), you must use
  `@dannywillems/rustc-bls12-381-node` (resp. `@dannywillems/rustc-bls12-381`).
- `bls12-381-js-gen`: if the module is loaded somewhere else than in the global
  namespace like the previous package supposes, you can use this third library
  that provides functors. The functors are expecting a module of the signature:
  ```ocaml
  sig
    val rust_module : unit -> Jsoo_lib.ESModule.t

    val get_wasm_memory_buffer : unit -> Jsoo_lib.Memory.Buffer.t
  end
  ```
  (note: functions are not directly evaluated values are required because the module might not already be loaded when loading the JavaScript resulting file and the wasm memory buffer being a view over a ArrayBuffer might be invalid if the buffer size is increased on runtime). You can see an example in the `src/js`.

For more examples, see the test directories.

## Run the benchmarks

**USE THE RELEASE VERSION OF THE RUST LIBRARY TO GET PRODUCTION BENCHMARKS (cargo build --release)**

```
opam install core_bench
dune exec benchmark/bench_ec.exe
dune exec benchmark/bench_ff.exe
dune exec benchmark/bench_pairing.exe
```

## Documentation

- Use `dune build @doc` to generate the API documentation.
