module MakeStubs : functor
  (M : sig
     val rust_module : unit -> Jsoo_lib.ESModule.t

     val get_wasm_memory_buffer : unit -> Jsoo_lib_rust_wasm.Memory.Buffer.t
   end)
  -> Bls12_381_base.Ff_sig.RAW_BASE

include Bls12_381_base.Fr.T
