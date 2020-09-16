module MakeUncompressedStubs (M : sig
  val rust_module : Jsoo_lib.ESModule.t

  val wasm_memory_buffer : Jsoo_lib_rust_wasm.Memory.Buffer.t
end) : Bls12_381_base.G1.RAW_UNCOMPRESSED = struct
  open Js_of_ocaml
  open Js_of_ocaml.Js.Unsafe

  let size_in_bytes = 192

  let check_bytes bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_uncompressed_check_bytes")
         [| inject 0 |]

  let is_zero bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call (get M.rust_module "rustc_bls12_381_g1_is_zero") [| inject 0 |]

  let zero () =
    ignore
    @@ fun_call (get M.rust_module "rustc_bls12_381_g1_zero") [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let one () =
    ignore
    @@ fun_call (get M.rust_module "rustc_bls12_381_g1_one") [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let random () =
    ignore
    @@ fun_call (get M.rust_module "rustc_bls12_381_g1_random") [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let add x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      (2 * size_in_bytes)
      size_in_bytes ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_add")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let mul x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      (2 * size_in_bytes)
      32 ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_mul")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let eq x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      0
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      size_in_bytes
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_eq")
         [| inject 0; inject size_in_bytes |]

  let negate x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_negate")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let double x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_double")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let build_from_components x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      48 ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      (size_in_bytes + 48)
      48 ;
    let res =
      Js.to_bool
      @@ fun_call
           (get M.rust_module "rustc_bls12_381_g1_build_from_components")
           [| inject 0; inject size_in_bytes; inject (size_in_bytes + 48) |]
    in
    if res then
      let res =
        Jsoo_lib_rust_wasm.Memory.Buffer.slice
          M.wasm_memory_buffer
          0
          size_in_bytes
      in
      Some (Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res)
    else None
end

module MakeCompressedStubs (M : sig
  val rust_module : Jsoo_lib.ESModule.t

  val wasm_memory_buffer : Jsoo_lib_rust_wasm.Memory.Buffer.t
end) : Bls12_381_base.G1.RAW_COMPRESSED = struct
  open Js_of_ocaml
  open Js_of_ocaml.Js.Unsafe

  let size_in_bytes = 96

  let check_bytes bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_check_bytes")
         [| inject 0 |]

  let is_zero bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_is_zero")
         [| inject 0 |]

  let zero () =
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_zero")
         [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let one () =
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_one")
         [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let random () =
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_random")
         [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let add x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      (2 * size_in_bytes)
      size_in_bytes ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_add")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let mul x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      (2 * size_in_bytes)
      32 ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_mul")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let eq x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      0
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      y
      0
      size_in_bytes
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_eq")
         [| inject 0; inject size_in_bytes |]

  let negate x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_negate")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let double x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      M.wasm_memory_buffer
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get M.rust_module "rustc_bls12_381_g1_compressed_double")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        M.wasm_memory_buffer
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res
end

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
