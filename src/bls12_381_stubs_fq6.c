#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>

extern int rustc_bls12_381_fq6_is_zero(const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq6_is_zero(value x) {
  int res = rustc_bls12_381_fq6_is_zero(Bytes_val(x));
  return Val_bool(res);
}

extern int rustc_bls12_381_fq6_is_one(const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq6_is_one(value x) {
  int res = rustc_bls12_381_fq6_is_one(Bytes_val(x));
  return Val_bool(res);
}

extern void rustc_bls12_381_fq6_random(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq6_random(value buffer) {
  rustc_bls12_381_fq6_random(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq6_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq6_one(value buffer) {
  rustc_bls12_381_fq6_one(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq6_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq6_zero(value buffer) {
  rustc_bls12_381_fq6_zero(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq6_add(unsigned char *buffer,
                                    const unsigned char *x,
                                    const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq6_add(value buffer, value x, value y) {
  rustc_bls12_381_fq6_add(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern int rustc_bls12_381_fq6_eq(const unsigned char *x,
                                    const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq6_eq(value x, value y) {
  int res = rustc_bls12_381_fq6_eq(Bytes_val(x), Bytes_val(y));
  return Val_bool(res);
}

extern void rustc_bls12_381_fq6_mul(unsigned char *buffer,
                                    const unsigned char *x,
                                    const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq6_mul(value buffer, value x, value y) {
  rustc_bls12_381_fq6_mul(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern void rustc_bls12_381_fq6_unsafe_inverse(unsigned char *buffer,
                                        const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq6_unsafe_inverse(value buffer, value x) {
  rustc_bls12_381_fq6_unsafe_inverse(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}

extern void rustc_bls12_381_fq6_negate(unsigned char *buffer,
                                       const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq6_negate(value buffer, value x) {
  rustc_bls12_381_fq6_negate(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}
