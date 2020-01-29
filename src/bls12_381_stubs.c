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

extern int rustc_bls12_381_fq_is_one(const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq_is_one(value x) {
  int res = rustc_bls12_381_fq_is_one(Bytes_val(x));
  return Val_bool(res);
}

extern void rustc_bls12_381_fq_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq_zero(value buffer) {
  rustc_bls12_381_fq_zero(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq_one(value buffer) {
  rustc_bls12_381_fq_one(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq_random(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq_random(value buffer) {
  rustc_bls12_381_fq_random(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq_add(unsigned char *buffer, const unsigned char *x, const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq_add(value buffer, value x, value y) {
  rustc_bls12_381_fq_add(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern void rustc_bls12_381_fq_mul(unsigned char *buffer,
                                   const unsigned char *x,
                                   const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq_mul(value buffer, value x, value y) {
  rustc_bls12_381_fq_mul(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern int rustc_bls12_381_fq_eq(const unsigned char *x,
                                  const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq_eq(value x, value y) {
  int res = rustc_bls12_381_fq_eq(Bytes_val(x), Bytes_val(y));
  return Val_bool(res);
}
