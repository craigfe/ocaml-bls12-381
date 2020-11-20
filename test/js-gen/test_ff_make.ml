let rec repeat ?(n = 100) f =
  if n <= 0 then
    let f () = () in
    f
  else (
    f () ;
    repeat ~n:(n - 1) f )

(** Check the routine generators do not raise any exception *)
module MakeValueGeneration (FiniteField : Ff.BASE) = struct
  let zero () = ignore @@ FiniteField.zero

  let random () = ignore @@ FiniteField.random ()

  let non_null_random () =
    ignore @@ not (FiniteField.is_zero (FiniteField.non_null_random ()))

  let one () = ignore @@ FiniteField.one

  let inverse_with_random_not_null () =
    let r = FiniteField.non_null_random () in
    ignore @@ FiniteField.inverse_exn r

  let inverse_with_one () = ignore @@ FiniteField.inverse_exn FiniteField.one

  let negation_with_random () =
    let random = FiniteField.random () in
    ignore @@ FiniteField.negate random

  let negation_with_zero () = ignore @@ FiniteField.negate FiniteField.zero

  let negation_with_one () = ignore @@ FiniteField.negate FiniteField.one

  let square_with_one () = ignore @@ FiniteField.square FiniteField.one

  let square_with_random () =
    let g = FiniteField.random () in
    ignore @@ FiniteField.square g

  let double_with_zero () = ignore @@ FiniteField.double FiniteField.zero

  let double_with_one () = ignore @@ FiniteField.double FiniteField.one

  let double_with_random () =
    let g = FiniteField.random () in
    ignore @@ FiniteField.double g

  let double_is_same_than_multiply_by_same_element () =
    let g = FiniteField.random () in
    assert (FiniteField.eq (FiniteField.double g) (FiniteField.add g g))

  let get_tests () =
    ( "Value generation",
      [ ("zero", repeat zero);
        ("random", repeat random);
        ("non null random", repeat ~n:100 non_null_random);
        ("inverse_random_not_null", repeat inverse_with_random_not_null);
        ("negate_with_one", repeat negation_with_one);
        ("negate_with_zero", repeat negation_with_zero);
        ("double_with_one", repeat double_with_one);
        ("double_with_zero", repeat double_with_zero);
        ("double_with_random", repeat double_with_random);
        ("square_with_one", repeat square_with_one);
        ("square_with_random", repeat square_with_random);
        ("negate_with_random", repeat negation_with_random);
        ( "double_is_same_than_multiply_by_same_element",
          repeat double_is_same_than_multiply_by_same_element );
        ("inverse_one", repeat inverse_with_one) ] )
end

module MakeIsZero (FiniteField : Ff.BASE) = struct
  let with_zero_value () = assert (FiniteField.is_zero FiniteField.zero = true)

  let rec with_random_value () =
    let x = FiniteField.random () in
    if FiniteField.is_zero x then with_random_value ()
    else assert (FiniteField.is_zero x = false)

  let get_tests () =
    ( "is_zero",
      [ ("with zero value", repeat with_zero_value);
        ("with random value", repeat with_random_value) ] )
end

module MakeEquality (FiniteField : Ff.BASE) = struct
  let zero_same_objects () =
    assert (FiniteField.eq FiniteField.zero FiniteField.zero)

  let one_same_objects () =
    assert (FiniteField.eq FiniteField.one FiniteField.one)

  let random_same_objects () =
    let random = FiniteField.random () in
    assert (FiniteField.eq random random)

  (* Low probability to be true on Fr and Fq12 *)
  let two_random_objects_not_equal () =
    assert (not (FiniteField.eq (FiniteField.random ()) (FiniteField.random ())))

  let get_tests () =
    ( "Equality",
      [ ("zero_same_objects", repeat zero_same_objects);
        ("one_same_objects", repeat one_same_objects);
        ("random_not_equal", repeat ~n:10 two_random_objects_not_equal);
        ("random_same_objects", repeat random_same_objects) ] )
end

module MakeFieldProperties (FiniteField : Ff.BASE) = struct
  let zero_nullifier_random () =
    (* 0 * g = 0 *)
    let random = FiniteField.random () in
    assert (FiniteField.is_zero (FiniteField.mul FiniteField.zero random))

  let zero_nullifier_zero () =
    (* Special case 0 * 0 = 0 *)
    assert (
      FiniteField.is_zero (FiniteField.mul FiniteField.zero FiniteField.zero) )

  let zero_nullifier_one () =
    (* Special case 0 * 1 = 0 *)
    assert (
      FiniteField.is_zero (FiniteField.mul FiniteField.zero FiniteField.one) )

  let rec inverse_property () =
    let random = FiniteField.random () in
    if FiniteField.is_zero random then inverse_property ()
    else
      assert (
        FiniteField.eq
          (FiniteField.mul (FiniteField.inverse_exn random) random)
          FiniteField.one )

  let inverse_of_one_is_one () =
    assert (
      FiniteField.eq (FiniteField.inverse_exn FiniteField.one) FiniteField.one
    )

  let zero_has_no_inverse () =
    match FiniteField.inverse_opt FiniteField.zero with
    | Some _ -> assert false
    | None -> assert true

  let rec inverse_of_non_null_does_exist () =
    let random = FiniteField.random () in
    if FiniteField.is_zero random then inverse_of_non_null_does_exist ()
    else
      match FiniteField.inverse_opt random with
      | Some _ -> assert true
      | None -> assert false

  let rec inverse_of_inverse () =
    let random = FiniteField.random () in
    if FiniteField.is_zero random then inverse_of_inverse ()
    else
      assert (
        FiniteField.eq
          (FiniteField.inverse_exn (FiniteField.inverse_exn random))
          random )

  let opposite_property () =
    let random = FiniteField.random () in
    assert (
      FiniteField.eq
        (FiniteField.add (FiniteField.negate random) random)
        FiniteField.zero )

  let opposite_of_opposite () =
    let random = FiniteField.random () in
    assert (
      FiniteField.eq (FiniteField.negate (FiniteField.negate random)) random )

  let opposite_of_zero_is_zero () =
    assert (
      FiniteField.eq (FiniteField.negate FiniteField.zero) FiniteField.zero )

  let additive_associativity () =
    let g1 = FiniteField.random () in
    let g2 = FiniteField.random () in
    let g3 = FiniteField.random () in
    assert (
      FiniteField.eq
        (FiniteField.add (FiniteField.add g1 g2) g3)
        (FiniteField.add (FiniteField.add g2 g3) g1) )

  let distributivity () =
    let g1 = FiniteField.random () in
    let g2 = FiniteField.random () in
    let g3 = FiniteField.random () in
    assert (
      FiniteField.eq
        (FiniteField.mul (FiniteField.add g1 g2) g3)
        (FiniteField.add (FiniteField.mul g1 g3) (FiniteField.mul g2 g3)) )

  let multiplicative_associativity () =
    let g1 = FiniteField.random () in
    let g2 = FiniteField.random () in
    let g3 = FiniteField.random () in
    assert (
      FiniteField.eq
        (FiniteField.mul (FiniteField.mul g1 g2) g3)
        (FiniteField.mul (FiniteField.mul g2 g3) g1) )

  (** 0**0 = 1 *)
  let pow_zero_to_zero_is_one () =
    assert (
      FiniteField.eq (FiniteField.pow FiniteField.zero Z.zero) FiniteField.one
    )

  (** 0 ** n = 0, n != 0 *)
  let pow_zero_to_non_null_exponent_is_zero () =
    let n = Z.of_int (Random.int 1_000_000_000) in
    assert (FiniteField.eq (FiniteField.pow FiniteField.zero n) FiniteField.zero)

  let pow_zero_on_random_equals_one () =
    let r = FiniteField.random () in
    assert (FiniteField.eq (FiniteField.pow r Z.zero) FiniteField.one)

  let pow_zero_on_one_equals_one () =
    assert (
      FiniteField.eq (FiniteField.pow FiniteField.one Z.zero) FiniteField.one )

  let pow_one_on_random_element_equals_the_random_element () =
    let e = FiniteField.random () in
    assert (FiniteField.eq (FiniteField.pow e Z.one) e)

  let pow_two_on_random_element_equals_the_square () =
    let e = FiniteField.random () in
    assert (
      FiniteField.eq (FiniteField.pow e (Z.succ Z.one)) (FiniteField.square e)
    )

  (** x**(-n) = x**(g - 1 - n) where g is the order of the additive group *)
  let pow_to_negative_exponent () =
    let x = FiniteField.random () in
    let n = Z.of_int (Random.int 1_000_000_000) in
    assert (
      FiniteField.eq
        (FiniteField.pow x (Z.neg n))
        (FiniteField.pow x (Z.sub (Z.pred FiniteField.order) n)) )

  let pow_addition_property () =
    let g = FiniteField.random () in
    let x = Z.of_int (Random.int 1_000_000_000) in
    let y = Z.of_int (Random.int 1_000_000_000) in
    assert (
      FiniteField.eq
        (FiniteField.pow g (Z.add x y))
        (FiniteField.mul (FiniteField.pow g x) (FiniteField.pow g y)) )

  (** x**g = x where g = |(F, +, 0)| *)
  let pow_to_the_additive_group_order_equals_same_element () =
    let x = FiniteField.random () in
    assert (FiniteField.eq (FiniteField.pow x FiniteField.order) x)

  (** x**g = 1 where g = |(F, *, 1)| *)
  let rec pow_to_the_multiplicative_group_order_equals_one () =
    let x = FiniteField.random () in
    if FiniteField.is_zero x then
      pow_to_the_multiplicative_group_order_equals_one ()
    else
      assert (
        FiniteField.eq
          (FiniteField.pow x (Z.pred FiniteField.order))
          FiniteField.one )

  (** x**(n + g) = x**n where g = |(F, *, 1)| *)
  let pow_add_multiplicative_group_order_to_a_random_power () =
    let x = FiniteField.random () in
    let n = Z.of_int (Random.int 1_000_000_000) in
    let order = Z.pred FiniteField.order in
    assert (
      FiniteField.eq (FiniteField.pow x (Z.add n order)) (FiniteField.pow x n)
    )

  let get_tests () =
    ( "Field properties",
      [ ("zero_nullifier_one", repeat zero_nullifier_one);
        ("zero_nullifier_zero", repeat zero_nullifier_zero);
        ("zero_nullifier_random", repeat zero_nullifier_random);
        ("inverse_of_non_null_does_exist", repeat inverse_of_non_null_does_exist);
        ("inverse_of_one_is_one", repeat inverse_of_one_is_one);
        ("zero_has_no_inverse", repeat zero_has_no_inverse);
        ("inverse_of_inverse", repeat inverse_of_inverse);
        ("opposite_of_opposite", repeat opposite_of_opposite);
        ("opposite_of_zero_is_zero", repeat opposite_of_zero_is_zero);
        ("additive_associativity", repeat additive_associativity);
        ("distributivity", repeat distributivity);
        ( "pow zero on random element equals one",
          repeat pow_zero_on_random_equals_one );
        ("pow zero on one equals one", repeat pow_zero_on_one_equals_one);
        ( "pow one on random element equals the same element",
          repeat pow_one_on_random_element_equals_the_random_element );
        ( "pow two on random element equals the square",
          repeat pow_one_on_random_element_equals_the_random_element );
        ( "pow element to the additive group order",
          repeat pow_to_the_additive_group_order_equals_same_element );
        ( "pow element to the multiplicative group order",
          repeat pow_to_the_multiplicative_group_order_equals_one );
        ( "pow element to a random power plus the additive group order",
          repeat pow_add_multiplicative_group_order_to_a_random_power );
        ("pow zero to zero is one", repeat ~n:1 pow_zero_to_zero_is_one);
        ( "pow zero to non null exponent is zero",
          repeat pow_zero_to_non_null_exponent_is_zero );
        ("pow to negative exponent", repeat pow_to_negative_exponent);
        ("opposite property", repeat opposite_property);
        ("inverse property", repeat inverse_property);
        ("pow addition property", repeat pow_addition_property);
        ("multiplicative_associativity", repeat multiplicative_associativity) ]
    )
end

module MakeMemoryRepresentation (FiniteField : Ff.BASE) = struct
  let test_to_bytes_has_correct_size () =
    let x = FiniteField.random () in
    let x_bytes = FiniteField.to_bytes x in
    assert (Bytes.length x_bytes = FiniteField.size_in_bytes)

  let test_to_bytes_of_bytes_inverse () =
    let x = FiniteField.random () in
    let x_bytes = FiniteField.to_bytes x in
    assert (FiniteField.eq x (FiniteField.of_bytes_exn x_bytes))

  let get_tests () =
    ( "Memory representation",
      [ ( "to_bytes returns the correct number of bytes",
          repeat test_to_bytes_has_correct_size );
        ( "to_bytes and of bytes are inverses",
          repeat test_to_bytes_of_bytes_inverse ) ] )
end
