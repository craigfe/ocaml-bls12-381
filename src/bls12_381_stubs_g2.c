#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>

extern void rustc_bls12_381_g2_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_g2_one(value buffer) {
  rustc_bls12_381_g2_one(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_g2_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_g2_zero(value buffer) {
  rustc_bls12_381_g2_zero(Bytes_val(buffer));
  return Val_unit;
}

extern void rustc_bls12_381_g2_random(unsigned char *element);

CAMLprim value ml_librustc_bls12_381_g2_random(value element) {
  rustc_bls12_381_g2_random(Bytes_val(element));
  return Val_unit;
}

extern void rustc_bls12_381_g2_add(unsigned char *buffer, const unsigned char* g1, const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_g2_add(value buffer, value g1, value g2) {
  rustc_bls12_381_g2_add(Bytes_val(buffer), Bytes_val(g1), Bytes_val(g2));
  return Val_unit;
}

extern void rustc_bls12_381_g2_negate(unsigned char *buffer,
                                      const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g2_negate(value buffer, value g) {
  rustc_bls12_381_g2_negate(Bytes_val(buffer), Bytes_val(g));
  return Val_unit;
}

extern int rustc_bls12_381_g2_eq(const unsigned char *g1,
                                 const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_g2_eq(value g1, value g2) {
  int res = rustc_bls12_381_g2_eq(Bytes_val(g1), Bytes_val(g2));
  return Val_bool(res);
}

extern int rustc_bls12_381_g2_is_zero(const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g2_is_zero(value g) {
  int res = rustc_bls12_381_g2_is_zero(Bytes_val(g));
  return Val_bool(res);
}

extern void rustc_bls12_381_g2_mul(unsigned char *buffer,
                                  const unsigned char *g,
                                  const unsigned char *a);

CAMLprim value ml_librustc_bls12_381_g2_mul(value buffer, value g, value a) {
  rustc_bls12_381_g2_mul(Bytes_val(buffer), Bytes_val(g), Bytes_val(a));
  return Val_unit;
}

extern void
rustc_bls12_381_g2_compressed_of_uncompressed(unsigned char *buffer,
                                              const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g2_compressed_of_uncompressed(value buffer,
                                                                   value g) {
  rustc_bls12_381_g2_compressed_of_uncompressed(Bytes_val(buffer),
                                                Bytes_val(g));
  return Val_unit;
}

extern void
rustc_bls12_381_g2_uncompressed_of_compressed(unsigned char *buffer,
                                              const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g2_uncompressed_of_compressed(value buffer,
                                                                   value g) {
  rustc_bls12_381_g2_uncompressed_of_compressed(Bytes_val(buffer),
                                                Bytes_val(g));
  return Val_unit;
}
