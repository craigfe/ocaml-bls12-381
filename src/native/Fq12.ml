module Fq12_stubs = Rustc_bls12_381_bindings.Fq12 (Rustc_bls12_381_stubs)

module Stubs = struct
  let check_bytes bs = Fq12_stubs.check_bytes (Ctypes.ocaml_bytes_start bs)

  let is_zero bs = Fq12_stubs.is_zero (Ctypes.ocaml_bytes_start bs)

  let is_one bs = Fq12_stubs.is_one (Ctypes.ocaml_bytes_start bs)

  let zero bs = Fq12_stubs.zero (Ctypes.ocaml_bytes_start bs)

  let one bs = Fq12_stubs.one (Ctypes.ocaml_bytes_start bs)

  let random bs = Fq12_stubs.random (Ctypes.ocaml_bytes_start bs)

  let add buffer x y =
    Fq12_stubs.add
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y)

  let mul buffer x y =
    Fq12_stubs.mul
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start y)

  let unsafe_inverse buffer x =
    Fq12_stubs.unsafe_inverse
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let eq x y =
    Fq12_stubs.eq (Ctypes.ocaml_bytes_start x) (Ctypes.ocaml_bytes_start y)

  let negate buffer x =
    Fq12_stubs.negate
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let square buffer x =
    Fq12_stubs.square
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let double buffer x =
    Fq12_stubs.double
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)

  let pow buffer x n =
    Fq12_stubs.pow
      (Ctypes.ocaml_bytes_start buffer)
      (Ctypes.ocaml_bytes_start x)
      (Ctypes.ocaml_bytes_start n)
end

include Bls12_381_base.Fq12.MakeFq12 (Stubs)
