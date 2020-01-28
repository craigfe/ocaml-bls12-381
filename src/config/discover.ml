module C = Configurator.V1

let () =
  let libdir = "-L" ^ Sys.getenv "OPAM_SWITCH_PREFIX" ^ "/lib/librustc-bls12-381" in
  C.Flags.write_sexp "flags.sexp" ["-lpthread"; libdir; "-lrustc_bls12_381"]
