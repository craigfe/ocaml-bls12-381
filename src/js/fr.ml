open Js_of_ocaml

module MakeStubs (M : sig
  val rust_module : unit -> Jsoo_lib.ESModule.t

  val get_wasm_memory_buffer : unit -> Jsoo_lib_rust_wasm.Memory.Buffer.t
end) : Bls12_381_base.Ff_sig.RAW_BASE = struct
  open Js.Unsafe

  let order =
    Z.of_string
      "52435875175126190479447740508185965837690552500527637822603658699938581184513"

  let size_in_bytes = 32

  let check_bytes bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_check_bytes")
         [| inject 0 |]

  let is_zero bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_is_zero")
         [| inject 0 |]

  let is_one bs =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      bs
      0
      0
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_is_one")
         [| inject 0 |]

  let zero () =
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_zero")
         [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let one () =
    ignore
    @@ fun_call (get (M.rust_module ()) "rustc_bls12_381_fr_one") [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let random () =
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_random")
         [| inject 0 |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let add x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      y
      0
      (2 * size_in_bytes)
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_add")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    (* The value is gonna be in the first 32 bytes of the buffer *)
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let mul x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      y
      0
      (2 * size_in_bytes)
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_mul")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    (* The value is gonna be in the first 32 bytes of the buffer *)
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let unsafe_inverse x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_unsafe_inverse")
         [| inject 0; inject size_in_bytes |] ;
    (* The value is gonna be in the first 32 bytes of the buffer *)
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let eq x y =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      0
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      y
      0
      size_in_bytes
      size_in_bytes ;
    Js.to_bool
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_eq")
         [| inject 0; inject size_in_bytes |]

  let negate x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_negate")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let square x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_square")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let double x =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_double")
         [| inject 0; inject size_in_bytes |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res

  let pow x n =
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      x
      0
      size_in_bytes
      size_in_bytes ;
    Jsoo_lib_rust_wasm.Memory.copy_in_buffer
      (M.get_wasm_memory_buffer ())
      n
      0
      (2 * size_in_bytes)
      size_in_bytes ;
    ignore
    @@ fun_call
         (get (M.rust_module ()) "rustc_bls12_381_fr_pow")
         [| inject 0; inject size_in_bytes; inject (2 * size_in_bytes) |] ;
    let res =
      Jsoo_lib_rust_wasm.Memory.Buffer.slice
        (M.get_wasm_memory_buffer ())
        0
        size_in_bytes
    in
    Jsoo_lib_rust_wasm.Memory.Buffer.to_bytes res
end

module Fr = Bls12_381_base.Fr.MakeFr (MakeStubs (struct
  open Js

  let rust_module () : Jsoo_lib.ESModule.t =
    Js_of_ocaml.Firebug.console##log Unsafe.global ;
    Jsoo_lib.ESModule.of_js Unsafe.global ##. HELLO

  let get_wasm_memory_buffer () =
    Jsoo_lib_rust_wasm.Memory.Buffer.of_js
      (Unsafe.get
         (Unsafe.get (Unsafe.get (rust_module ()) "__wasm") "memory")
         "buffer")
end))

include Fr
