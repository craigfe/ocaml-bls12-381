#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>


extern int rustc_bls12_381_fr_is_zero(const unsigned char *element);

CAMLprim value ml_librustc_bls12_381_fr_is_zero(value element) {
  int res = rustc_bls12_381_fr_is_zero(Bytes_val(element));
  return Val_bool(res);
}

extern int rustc_bls12_381_fr_is_one(const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fr_is_one(value x) {
  int res = rustc_bls12_381_fr_is_one(Bytes_val(x));
  return Val_bool(res);
}

extern void rustc_bls12_381_fr_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fr_zero(value buffer) {
  rustc_bls12_381_fr_zero(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fr_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fr_one(value buffer) {
  rustc_bls12_381_fr_one(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fr_random(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fr_random(value buffer) {
  rustc_bls12_381_fr_random(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fr_add(unsigned char *buffer, const unsigned char *x, const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fr_add(value buffer, value x, value y) {
  rustc_bls12_381_fr_add(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern void rustc_bls12_381_fr_mul(unsigned char *buffer,
                                   const unsigned char *x,
                                   const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fr_mul(value buffer, value x, value y) {
  rustc_bls12_381_fr_mul(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern void rustc_bls12_381_fr_unsafe_inverse(unsigned char *buffer,
                                              const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fr_unsafe_inverse(value buffer, value x, value y) {
  rustc_bls12_381_fr_unsafe_inverse(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}

extern void rustc_bls12_381_fr_negate(unsigned char *buffer,
                                      const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fr_negate(value buffer, value x) {
  rustc_bls12_381_fr_negate(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}

extern int rustc_bls12_381_fr_eq(const unsigned char *x,
                                 const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fr_eq(value x, value y) {
  int res = rustc_bls12_381_fr_eq(Bytes_val(x), Bytes_val(y));
  return Val_bool(res);
}
