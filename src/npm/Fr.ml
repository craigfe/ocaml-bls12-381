open Js_of_ocaml

let es_module : Jsoo_lib.ESModule.t =
  Jsoo_lib.ESModule.of_js Js_of_ocaml.Js.Unsafe.global##._RUSTC_BLS12_381

exception Not_in_field of Bytes.t

let size_in_bytes = 32

let order =
  Z.of_string
    "52435875175126190479447740508185965837690552500527637822603658699938581184513"

type t = Bytes.t

(* let check_bytes bs =
 *   if Bytes.length bs = size_in_bytes then
 * 
 *     Fr.check_bytes (Ctypes.ocaml_bytes_start bs)
 *   else false
 * 
 * let of_bytes_opt bs = if check_bytes bs then Some bs else None
 * 
 * let of_bytes_exn (g : Bytes.t) : t =
 *   if check_bytes g then g else raise (Not_in_field g)
 * 
 * let to_bytes g = g *)

let is_zero g =
  let open Js.Unsafe in
  Jsoo_lib_rust_wasm.Memory.copy_in_buffer es_module g 0 0 32 ;
  Js.to_bool
    (fun_call (get es_module "rustc_bls12_381_fr_is_zero") [| inject 0 |])

let is_one g =
  let open Js.Unsafe in
  Jsoo_lib_rust_wasm.Memory.copy_in_buffer es_module g 0 0 32 ;
  Js.to_bool
    (fun_call (get es_module "rustc_bls12_381_fr_is_one") [| inject 0 |])

(* let zero =
 *   let g = empty () in
 *   Fr_stubs.zero (Ctypes.ocaml_bytes_start g) ;
 *   g
 * 
 * let one =
 *   let g = empty () in
 *   Fr_stubs.one (Ctypes.ocaml_bytes_start g) ;
 *   g *)

let add a b =
  let open Js.Unsafe in
  Jsoo_lib_rust_wasm.Memory.copy_in_buffer es_module a 0 32 32 ;
  Jsoo_lib_rust_wasm.Memory.copy_in_buffer es_module b 0 64 32 ;
  ignore
  @@ fun_call
       (get es_module "rustc_bls12_381_fr_add")
       [| inject 0; inject 32; inject 64 |] ;
  (* The value is gonna be in the first 32 bytes of the buffer *)
  let memory = Jsoo_lib_rust_wasm.Memory.get_buffer es_module in
  let res = Jsoo_lib_rust_wasm.Memory.Buffer.slice memory 0 32 in
  res

let () =
  let open Jsoo_lib in
  Js.export
    "Fr"
    (object%js
       method add a b =
         add
           Uint8TypedArray.(to_bytes (of_js a))
           Uint8TypedArray.(to_bytes (of_js b))

       method isOne g = is_one Uint8TypedArray.(to_bytes (of_js g))

       method isZero g = is_zero Uint8TypedArray.(to_bytes (of_js g))
    end)
