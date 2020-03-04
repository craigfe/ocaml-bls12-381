#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>

extern bool rustc_bls12_381_g1_uncompressed_is_on_curve(const unsigned char *element);

CAMLprim value ml_librustc_bls12_381_g1_uncompressed_is_on_curve(value element) {
  bool res = rustc_bls12_381_g1_uncompressed_is_on_curve(Bytes_val(element));
  return Val_bool(res);
}

extern bool rustc_bls12_381_g1_compressed_is_on_curve(const unsigned char *element);

CAMLprim value ml_librustc_bls12_381_g1_compressed_is_on_curve(value element) {
  bool res = rustc_bls12_381_g1_compressed_is_on_curve(Bytes_val(element));
  return Val_bool(res);
}

extern void rustc_bls12_381_g1_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_g1_one(value buffer) {
  CAMLparam1(buffer);
  rustc_bls12_381_g1_one(Bytes_val(buffer));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_g1_zero(value buffer) {
  CAMLparam1(buffer);
  rustc_bls12_381_g1_zero(Bytes_val(buffer));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_random(unsigned char *element);

CAMLprim value ml_librustc_bls12_381_g1_random(value element) {
  CAMLparam1(element);
  rustc_bls12_381_g1_random(Bytes_val(element));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_add(unsigned char *buffer, const unsigned char* g1, const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_g1_add(value buffer, value g1, value g2) {
  CAMLparam3(buffer, g1, g2);
  rustc_bls12_381_g1_add(Bytes_val(buffer), Bytes_val(g1), Bytes_val(g2));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_negate(unsigned char *buffer,
                                      const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g1_negate(value buffer, value g) {
  CAMLparam2(buffer, g);
  rustc_bls12_381_g1_negate(Bytes_val(buffer), Bytes_val(g));
  CAMLreturn(Val_unit);
}

extern bool rustc_bls12_381_g1_eq(const unsigned char *g1,
                                  const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_g1_eq(value g1, value g2) {
  CAMLparam2(g1, g2);
  bool res = rustc_bls12_381_g1_eq(Bytes_val(g1), Bytes_val(g2));
  CAMLreturn(Val_bool(res));
}

extern bool rustc_bls12_381_g1_is_zero(const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g1_is_zero(value g) {
  CAMLparam1(g);
  bool res = rustc_bls12_381_g1_is_zero(Bytes_val(g));
  CAMLreturn(Val_bool(res));
}

extern void rustc_bls12_381_g1_mul(unsigned char *buffer,
                                  const unsigned char *g,
                                  const unsigned char *a);

CAMLprim value ml_librustc_bls12_381_g1_mul(value buffer, value g, value a) {
  CAMLparam3(buffer, g, a);
  rustc_bls12_381_g1_mul(Bytes_val(buffer), Bytes_val(g), Bytes_val(a));
  CAMLreturn(Val_unit);
}

// ---------------- G1 Compressed ------------
extern void rustc_bls12_381_g1_compressed_add(unsigned char *buffer, const unsigned char* g1, const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_g1_compressed_add(value buffer, value g1, value g2) {
  CAMLparam3(buffer, g1, g2);
  rustc_bls12_381_g1_compressed_add(Bytes_val(buffer), Bytes_val(g1), Bytes_val(g2));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_compressed_negate(unsigned char *buffer,
                                                 const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g1_compressed_negate(value buffer, value g) {
  CAMLparam2(buffer, g);
  rustc_bls12_381_g1_compressed_negate(Bytes_val(buffer), Bytes_val(g));
  CAMLreturn(Val_unit);
}

extern bool rustc_bls12_381_g1_compressed_eq(const unsigned char *g1,
                                             const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_g1_compressed_eq(value g1, value g2) {
  CAMLparam2(g1, g2);
  bool res = rustc_bls12_381_g1_compressed_eq(Bytes_val(g1), Bytes_val(g2));
  CAMLreturn(Val_bool(res));
}

extern bool rustc_bls12_381_g1_compressed_is_zero(const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g1_compressed_is_zero(value g) {
  CAMLparam1(g);
  bool res = rustc_bls12_381_g1_compressed_is_zero(Bytes_val(g));
  CAMLreturn(Val_bool(res));
}

extern void rustc_bls12_381_g1_compressed_of_uncompressed(unsigned char *buffer,
                                                          const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g1_compressed_of_uncompressed(value buffer, value g) {
  CAMLparam2(buffer, g);
  rustc_bls12_381_g1_compressed_of_uncompressed(Bytes_val(buffer), Bytes_val(g));
  CAMLreturn(Val_unit);
}

extern void
rustc_bls12_381_g1_uncompressed_of_compressed(unsigned char *buffer,
                                              const unsigned char *g);

CAMLprim value ml_librustc_bls12_381_g1_uncompressed_of_compressed(value buffer,
                                                         value g) {
  CAMLparam2(buffer, g);
  rustc_bls12_381_g1_uncompressed_of_compressed(Bytes_val(buffer),
                                                Bytes_val(g));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_compressed_one(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_g1_compressed_one(value buffer) {
  CAMLparam1(buffer);
  rustc_bls12_381_g1_compressed_one(Bytes_val(buffer));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_compressed_zero(unsigned char *buffer);

CAMLprim value ml_librustc_bls12_381_g1_compressed_zero(value buffer) {
  CAMLparam1(buffer);
  rustc_bls12_381_g1_compressed_zero(Bytes_val(buffer));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_compressed_random(unsigned char *element);

CAMLprim value ml_librustc_bls12_381_g1_compressed_random(value element) {
  CAMLparam1(element);
  rustc_bls12_381_g1_compressed_random(Bytes_val(element));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_g1_compressed_mul(unsigned char *buffer,
                                              const unsigned char *g,
                                              const unsigned char *a);

CAMLprim value ml_librustc_bls12_381_g1_compressed_mul(value buffer, value g, value a) {
  CAMLparam3(buffer, g, a);
  rustc_bls12_381_g1_compressed_mul(Bytes_val(buffer), Bytes_val(g), Bytes_val(a));
  CAMLreturn(Val_unit);
}
