#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>

extern int rustc_bls12_381_fq2_is_zero(const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq2_is_zero(value x) {
  int res = rustc_bls12_381_fq2_is_zero(Bytes_val(x));
  return Val_bool(res);
}

extern int rustc_bls12_381_fq2_is_one(const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq2_is_one(value x) {
  int res = rustc_bls12_381_fq2_is_one(Bytes_val(x));
  return Val_bool(res);
}

extern void rustc_bls12_381_fq2_random(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq2_random(value buffer) {
  rustc_bls12_381_fq2_random(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq2_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq2_one(value buffer) {
  rustc_bls12_381_fq2_one(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq2_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_fq2_zero(value buffer) {
  rustc_bls12_381_fq2_zero(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_fq2_add(unsigned char *buffer,
                                    const unsigned char *x,
                                    const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq2_add(value buffer, value x, value y) {
  rustc_bls12_381_fq2_add(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern int rustc_bls12_381_fq2_eq(const unsigned char *x,
                                    const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq2_eq(value x, value y) {
  int res = rustc_bls12_381_fq2_eq(Bytes_val(x), Bytes_val(y));
  return Val_bool(res);
}

extern void rustc_bls12_381_fq2_mul(unsigned char *buffer,
                                    const unsigned char *x,
                                    const unsigned char *y);

CAMLprim value ml_librustc_bls12_381_fq2_mul(value buffer, value x, value y) {
  rustc_bls12_381_fq2_mul(Bytes_val(buffer), Bytes_val(x), Bytes_val(y));
  return Val_unit;
}

extern void rustc_bls12_381_fq2_unsafe_inverse(unsigned char *buffer,
                                        const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq2_unsafe_inverse(value buffer, value x) {
  rustc_bls12_381_fq2_unsafe_inverse(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}

extern void rustc_bls12_381_fq2_negate(unsigned char *buffer,
                                       const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_fq2_negate(value buffer, value x) {
  rustc_bls12_381_fq2_negate(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}
