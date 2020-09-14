module type T = sig
  include Ff.PRIME

  (** Check if a point, represented as a byte array, is in the field **)
  val check_bytes : Bytes.t -> bool
end

module MakeFr (Stubs : Ff_sig.RAW_BASE) : T = struct
  type t = Bytes.t

  exception Not_in_field of Bytes.t

  (** High level (OCaml) definitions/logic *)
  let size_in_bytes = 32

  let order =
    Z.of_string
      "52435875175126190479447740508185965837690552500527637822603658699938581184513"

  let empty () = Bytes.make size_in_bytes '\000'

  let check_bytes bs =
    if Bytes.length bs = size_in_bytes then Stubs.check_bytes bs else false

  let of_bytes_opt bs = if check_bytes bs then Some bs else None

  let of_bytes_exn (g : Bytes.t) : t =
    if check_bytes g then g else raise (Not_in_field g)

  let to_bytes g = g

  let is_zero g =
    assert (Bytes.length g = size_in_bytes) ;
    Stubs.is_zero g

  let is_one g =
    assert (Bytes.length g = size_in_bytes) ;
    Stubs.is_one g

  let zero =
    let g = empty () in
    Stubs.zero g ;
    g

  let one =
    let g = empty () in
    Stubs.one g ;
    g

  let random ?state () =
    ignore state ;
    let g = empty () in
    Stubs.random g ;
    g

  let rec non_null_random ?state () =
    ignore state ;
    let r = random () in
    if is_zero r then non_null_random () else r

  let add x y =
    assert (Bytes.length x = size_in_bytes) ;
    assert (Bytes.length y = size_in_bytes) ;
    let g = empty () in
    Stubs.add g x y ;
    g

  let ( + ) = add

  let mul x y =
    assert (Bytes.length x = size_in_bytes) ;
    assert (Bytes.length y = size_in_bytes) ;
    let g = empty () in
    Stubs.mul g x y ;
    g

  let ( * ) = mul

  let inverse_exn g =
    assert (Bytes.length g = size_in_bytes) ;
    let buffer = empty () in
    Stubs.unsafe_inverse buffer g ;
    buffer

  let inverse_opt g =
    assert (Bytes.length g = size_in_bytes) ;
    if is_zero g then None
    else
      let buffer = empty () in
      Stubs.unsafe_inverse buffer g ;
      Some buffer

  let negate g =
    assert (Bytes.length g = size_in_bytes) ;
    let buffer = empty () in
    Stubs.negate buffer g ;
    buffer

  let ( - ) = negate

  let square g =
    assert (Bytes.length g = size_in_bytes) ;
    let buffer = empty () in
    Stubs.square buffer g ;
    buffer

  let double g =
    assert (Bytes.length g = size_in_bytes) ;
    let buffer = empty () in
    Stubs.double buffer g ;
    buffer

  let eq x y = Stubs.eq x y

  let ( = ) = eq

  let to_string a = Z.to_string (Z.of_bits (Bytes.to_string a))

  let to_z a = Z.of_bits (Bytes.to_string a)

  let pow x n =
    let res = empty () in
    let n = Z.erem n (Z.pred order) in
    (* sign is removed by to_bits, but that's fine because we used mod before *)
    let n = Bytes.of_string (Z.to_bits n) in
    let bytes_size_n = Bytes.length n in
    let padded_n =
      Bytes.init size_in_bytes (fun i ->
          if i < bytes_size_n then Bytes.get n i else char_of_int 0)
    in
    Stubs.pow res (to_bytes x) padded_n ;
    res

  let ( ** ) = pow

  let of_string s =
    let g = empty () in
    let s = Bytes.of_string (Z.to_bits (Z.erem (Z.of_string s) order)) in
    Bytes.blit s 0 g 0 (min (Bytes.length s) size_in_bytes) ;
    of_bytes_exn g

  let of_z z =
    let z = Bytes.of_string (Z.to_bits (Z.erem z order)) in
    let x = empty () in
    Bytes.blit z 0 x 0 (min (Bytes.length z) size_in_bytes) ;
    of_bytes_exn x

  let div_exn a b =
    if b = zero then raise Division_by_zero else mul a (inverse_exn b)

  let div_opt a b = if b = zero then None else Some (mul a (inverse_exn b))

  let ( / ) = div_exn
end
