let () =
  let open Js_of_ocaml.Js in
  let open Js_of_ocaml in
  let p : (Jsoo_lib.ESModule.t, Unsafe.any) Jsoo_lib.Promise.t =
    Jsoo_lib.Promise.of_any_js
      (Unsafe.js_expr {| import("@dannywillems/rustc-bls12-381") |})
  in
  let on_resolved m =
    Firebug.console##log (Jsoo_lib.ESModule.to_any_js m) ;
    let module StubsFr = Bls12_381_js.Fr.MakeStubs (struct
      let rust_module = m
    end) in
    let module Fr = Bls12_381_base.Fr.MakeFr (StubsFr) in
    let a = Fr.random () in
    let b = Fr.random () in
    let sum = Fr.add a b in
    Firebug.console##log (Fr.to_string sum)
  in
  Jsoo_lib.Promise.then_bind ~on_resolved p
