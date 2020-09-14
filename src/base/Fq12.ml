module type T = sig
  include Ff.BASE

  (** Construct an element of Fq12 based on the following pattern:
    Fq12 =
     Fq6 (
       Fq2(x: x0, y: x1))
       Fq2(x: x2, y: x3))
       Fq2(x: x4, y: x5)),
     Fq6 (
       Fq2(x: x6, y: x7))
       Fq2(x: x8, y: x9))
       Fq2(x: x10, y: x11))
    x0, ..., x11 are the parameters of the function.
    No check is applied.

    Example of usage (pairing result of the multiplicative neutre elements):
    Fq12.of_string
      "2819105605953691245277803056322684086884703000473961065716485506033588504203831029066448642358042597501014294104502"
      "1323968232986996742571315206151405965104242542339680722164220900812303524334628370163366153839984196298685227734799"
      "2987335049721312504428602988447616328830341722376962214011674875969052835043875658579425548512925634040144704192135"
      "3879723582452552452538684314479081967502111497413076598816163759028842927668327542875108457755966417881797966271311"
      "261508182517997003171385743374653339186059518494239543139839025878870012614975302676296704930880982238308326681253"
      "231488992246460459663813598342448669854473942105054381511346786719005883340876032043606739070883099647773793170614"
      "3993582095516422658773669068931361134188738159766715576187490305611759126554796569868053818105850661142222948198557"
      "1074773511698422344502264006159859710502164045911412750831641680783012525555872467108249271286757399121183508900634"
      "2727588299083545686739024317998512740561167011046940249988557419323068809019137624943703910267790601287073339193943"
      "493643299814437640914745677854369670041080344349607504656543355799077485536288866009245028091988146107059514546594"
      "734401332196641441839439105942623141234148957972407782257355060229193854324927417865401895596108124443575283868655"
      "2348330098288556420918672502923664952620152483128593484301759394583320358354186482723629999370241674973832318248497"
    (* source for the test vectors: https://docs.rs/crate/pairing/0.16.0/source/src/bls12_381/tests/mod.rs *)

    Undefined behaviours if the given elements are not in the field or any other
    representation than decimal is used. Use this function carefully.

    See https://docs.rs/crate/pairing/0.16.0/source/src/bls12_381/README.md for
    more information on the instances used by the library.
*)
  val of_string :
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    String.t ->
    t

  (** Same than [of_string], using Z.t elements *)
  val of_z :
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    Z.t ->
    t
end

module MakeFq12 (Stubs : Ff_sig.RAW_BASE) : T = struct
  let size_in_bytes = 576

  exception Not_in_field of Bytes.t

  type t = Bytes.t

  let empty () = Bytes.make size_in_bytes '\000'

  let order =
    let fq_order =
      Z.of_string
        "4002409555221667393417789825735904156556882819939007885332058136124031650490837864442687629129015664037894272559787"
    in
    Z.pow fq_order 12

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

  let of_z x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 =
    let x0 = Bytes.of_string (Z.to_bits x0) in
    let x1 = Bytes.of_string (Z.to_bits x1) in
    let x2 = Bytes.of_string (Z.to_bits x2) in
    let x3 = Bytes.of_string (Z.to_bits x3) in
    let x4 = Bytes.of_string (Z.to_bits x4) in
    let x5 = Bytes.of_string (Z.to_bits x5) in
    let x6 = Bytes.of_string (Z.to_bits x6) in
    let x7 = Bytes.of_string (Z.to_bits x7) in
    let x8 = Bytes.of_string (Z.to_bits x8) in
    let x9 = Bytes.of_string (Z.to_bits x9) in
    let x10 = Bytes.of_string (Z.to_bits x10) in
    let x11 = Bytes.of_string (Z.to_bits x11) in
    let g = empty () in
    Bytes.blit x0 0 g 0 (min (Bytes.length x0) 48) ;
    Bytes.blit x1 0 g 48 (min (Bytes.length x1) 48) ;
    Bytes.blit x2 0 g 96 (min (Bytes.length x2) 48) ;
    Bytes.blit x3 0 g 144 (min (Bytes.length x3) 48) ;
    Bytes.blit x4 0 g 192 (min (Bytes.length x4) 48) ;
    Bytes.blit x5 0 g 240 (min (Bytes.length x5) 48) ;
    Bytes.blit x6 0 g 288 (min (Bytes.length x6) 48) ;
    Bytes.blit x7 0 g 336 (min (Bytes.length x7) 48) ;
    Bytes.blit x8 0 g 384 (min (Bytes.length x8) 48) ;
    Bytes.blit x9 0 g 432 (min (Bytes.length x9) 48) ;
    Bytes.blit x10 0 g 480 (min (Bytes.length x10) 48) ;
    Bytes.blit x11 0 g 528 (min (Bytes.length x11) 48) ;
    of_bytes_exn g

  let of_string x0 x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11 =
    let x0 = Bytes.of_string (Z.to_bits (Z.of_string x0)) in
    let x1 = Bytes.of_string (Z.to_bits (Z.of_string x1)) in
    let x2 = Bytes.of_string (Z.to_bits (Z.of_string x2)) in
    let x3 = Bytes.of_string (Z.to_bits (Z.of_string x3)) in
    let x4 = Bytes.of_string (Z.to_bits (Z.of_string x4)) in
    let x5 = Bytes.of_string (Z.to_bits (Z.of_string x5)) in
    let x6 = Bytes.of_string (Z.to_bits (Z.of_string x6)) in
    let x7 = Bytes.of_string (Z.to_bits (Z.of_string x7)) in
    let x8 = Bytes.of_string (Z.to_bits (Z.of_string x8)) in
    let x9 = Bytes.of_string (Z.to_bits (Z.of_string x9)) in
    let x10 = Bytes.of_string (Z.to_bits (Z.of_string x10)) in
    let x11 = Bytes.of_string (Z.to_bits (Z.of_string x11)) in
    let g = empty () in
    Bytes.blit x0 0 g 0 (min (Bytes.length x0) 48) ;
    Bytes.blit x1 0 g 48 (min (Bytes.length x1) 48) ;
    Bytes.blit x2 0 g 96 (min (Bytes.length x2) 48) ;
    Bytes.blit x3 0 g 144 (min (Bytes.length x3) 48) ;
    Bytes.blit x4 0 g 192 (min (Bytes.length x4) 48) ;
    Bytes.blit x5 0 g 240 (min (Bytes.length x5) 48) ;
    Bytes.blit x6 0 g 288 (min (Bytes.length x6) 48) ;
    Bytes.blit x7 0 g 336 (min (Bytes.length x7) 48) ;
    Bytes.blit x8 0 g 384 (min (Bytes.length x8) 48) ;
    Bytes.blit x9 0 g 432 (min (Bytes.length x9) 48) ;
    Bytes.blit x10 0 g 480 (min (Bytes.length x10) 48) ;
    Bytes.blit x11 0 g 528 (min (Bytes.length x11) 48) ;
    of_bytes_exn g

  let div_exn a b =
    if b = zero then raise Division_by_zero else mul a (inverse_exn b)

  let div_opt a b = if b = zero then None else Some (mul a (inverse_exn b))

  let ( / ) = div_exn
end
