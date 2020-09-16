let run_test_group (group_name, tests) =
  let open Js_of_ocaml in
  Firebug.console##log
    (Js.string @@ Printf.sprintf "---> Running test group %s" group_name) ;
  List.iter
    (fun (test_name, test) ->
      Firebug.console##log
        (Js.string @@ Printf.sprintf "-------> Running test %s" test_name) ;
      test ())
    tests

let run name test_suites =
  let open Js_of_ocaml in
  Firebug.console##log (Js.string @@ Printf.sprintf "Running test suite %s" name) ;
  List.iter run_test_group test_suites
