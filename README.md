1. Setup environment
```
opam switch create ./ 4.07.1
```

2. Install Rust dependencies


```
# static library will be installed here
mkdir _opam/lib/librustc-bls12-381/
git clone https://gitlab.com/dannywillems/rustc-bls12-381 /tmp/rustc-bls12-381
cd /tmp/rustc-bls12-381
cargo build
```
Then copy `target/debug/librustc_bls12_381.a` in `_opam/lib/librustc-bls12-381`

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
