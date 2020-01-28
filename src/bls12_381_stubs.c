#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>


extern int rustc_bls12_381_fq_is_zero(const unsigned char *element);

CAMLprim value ml_librustc_bls12_381_fq_is_zero(value element) {
  int res = rustc_bls12_381_fq_is_zero(Bytes_val(element));
  return Val_bool(res);
}

extern void rustc_bls12_381_fq_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq_zero(value buffer) {
  rustc_bls12_381_fq_zero(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq_random(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq_random(value buffer) {
  rustc_bls12_381_fq_random(Bytes_val(buffer));
  return Val_unit;
}
