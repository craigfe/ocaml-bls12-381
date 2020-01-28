external ml_bls12_381_fq_is_zero : Bytes.t -> bool
  = "ml_librustc_bls12_381_fq_is_zero"
  [@@noalloc]

external ml_bls12_381_fq_zero : Bytes.t -> unit
  = "ml_librustc_bls12_381_fq_zero"
  [@@noalloc]


type t = Bytes.t
let to_t (s : Bytes.t) : t = s

let is_zero s =
  assert (Bytes.length s = 48);
  ml_bls12_381_fq_is_zero s
let zero () =
  let s = Bytes.create 48 in
  ml_bls12_381_fq_zero s;
  (to_t s)

