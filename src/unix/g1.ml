module G1_stubs = Rustc_bls12_381_bindings.G1 (Rustc_bls12_381_stubs)

module Uncompressed_Stubs = struct
  let size_in_bytes = 96

  let empty () = Bytes.make size_in_bytes '\000'

  let check_bytes bs =
    G1_stubs.uncompressed_check_bytes (Ctypes.ocaml_bytes_start bs)

  let is_zero bs = G1_stubs.is_zero (Ctypes.ocaml_bytes_start bs)

  let zero () =
    let bs = empty () in
    G1_stubs.zero (Ctypes.ocaml_bytes_start bs) ;
    bs

  let one () =
    let bs = empty () in
    G1_stubs.one (Ctypes.ocaml_bytes_start bs) ;
    bs

  let random () =
    let bs = empty () in
    G1_stubs.random (Ctypes.ocaml_bytes_start bs) ;
    bs

  let add x y =
    let buffer = empty () in
    G1_stubs.add
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y) ;
    buffer

  let mul x y =
    let buffer = empty () in
    G1_stubs.mul
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y) ;
    buffer

  let eq x y =
    G1_stubs.eq (Ctypes.ocaml_bytes_start x) (Ctypes.ocaml_bytes_start y)

  let negate x =
    let buffer = empty () in
    G1_stubs.negate
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x) ;
    buffer

  let double x =
    let buffer = empty () in
    G1_stubs.double
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x) ;
    buffer

  let build_from_components x y =
    let buffer = empty () in
    let res =
      G1_stubs.build_from_components
        (Ctypes.ocaml_bytes_start buffer)
        (Ctypes.ocaml_bytes_start x)
        (Ctypes.ocaml_bytes_start y)
    in
    if res = false then None else Some buffer
end

module Compressed_Stubs = struct
  let size_in_bytes = 48

  let empty () = Bytes.make size_in_bytes '\000'

  let check_bytes bs =
    G1_stubs.compressed_check_bytes (Ctypes.ocaml_bytes_start bs)

  let is_zero bs = G1_stubs.compressed_is_zero (Ctypes.ocaml_bytes_start bs)

  let zero () =
    let bs = empty () in
    G1_stubs.compressed_zero (Ctypes.ocaml_bytes_start bs) ;
    bs

  let one () =
    let bs = empty () in
    G1_stubs.compressed_one (Ctypes.ocaml_bytes_start bs) ;
    bs

  let random () =
    let bs = empty () in
    G1_stubs.compressed_random (Ctypes.ocaml_bytes_start bs) ;
    bs

  let add x y =
    let buffer = empty () in
    G1_stubs.compressed_add
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y) ;
    buffer

  let mul x y =
    let buffer = empty () in
    G1_stubs.compressed_mul
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y) ;
    buffer

  let eq x y =
    G1_stubs.compressed_eq
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y)

  let negate x =
    let buffer = empty () in
    G1_stubs.compressed_negate
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x) ;
    buffer

  let double x =
    let buffer = empty () in
    G1_stubs.compressed_double
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x) ;
    buffer
end

module Uncompressed =
  Bls12_381_functors.G1_sig.MakeUncompressed (Fr) (Uncompressed_Stubs)
module Compressed =
  Bls12_381_functors.G1_sig.MakeCompressed (Fr) (Compressed_Stubs)

(* let compressed_of_uncompressed g =
 *   let buffer = Compressed.empty () in
 *   G1_stubs.compressed_of_uncompressed
 *     (Ctypes.ocaml_bytes_start (Compressed.to_bytes buffer))
 *     (Ctypes.ocaml_bytes_start (Uncompressed.to_bytes g)) ;
 *   Compressed.of_bytes_exn (Compressed.to_bytes buffer)
 * 
 * let uncompressed_of_compressed g =
 *   let buffer = Uncompressed.empty () in
 *   G1_stubs.uncompressed_of_compressed
 *     (Ctypes.ocaml_bytes_start (Uncompressed.to_bytes buffer))
 *     (Ctypes.ocaml_bytes_start (Compressed.to_bytes g)) ;
 *   Uncompressed.of_bytes_exn (Uncompressed.to_bytes buffer) *)
