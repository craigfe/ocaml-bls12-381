module Fr_stubs = Rustc_bls12_381_bindings.Fr (Rustc_bls12_381_stubs)

module Stubs = struct
  let check_bytes bs = Fr_stubs.check_bytes (Ctypes.ocaml_bytes_start bs)

  let is_zero bs = Fr_stubs.is_zero (Ctypes.ocaml_bytes_start bs)

  let is_one bs = Fr_stubs.is_one (Ctypes.ocaml_bytes_start bs)

  let zero bs = Fr_stubs.zero (Ctypes.ocaml_bytes_start bs)

  let one bs = Fr_stubs.one (Ctypes.ocaml_bytes_start bs)

  let random bs = Fr_stubs.random (Ctypes.ocaml_bytes_start bs)

  let add buffer x y =
    Fr_stubs.add
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y)

  let mul buffer x y =
    Fr_stubs.mul
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y)

  let unsafe_inverse buffer x =
    Fr_stubs.unsafe_inverse
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let eq x y =
    Fr_stubs.eq (Ctypes.ocaml_bytes_start x) (Ctypes.ocaml_bytes_start y)

  let negate buffer x =
    Fr_stubs.negate
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let square buffer x =
    Fr_stubs.square
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let double buffer x =
    Fr_stubs.double
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let pow buffer x n =
    Fr_stubs.pow
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start n)
end

include Bls12_381_base.Fr.MakeFr (Stubs)
