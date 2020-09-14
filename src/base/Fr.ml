module type T = sig
  include Ff.PRIME

  (** Check if a point, represented as a byte array, is in the field **)
  val check_bytes : Bytes.t -> bool
end

module MakeFr (Stubs : Ff_sig.RAW_BASE) : T = struct
  include Ff_sig.Make(Stubs)

  let empty () = Bytes.make size_in_bytes '\000'

  let to_string a = Z.to_string (Z.of_bits (Bytes.to_string (to_bytes a)))

  let to_z a = Z.of_bits (Bytes.to_string (to_bytes a))

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
end
