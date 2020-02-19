#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>

extern void rustc_bls12_381_pairing_miller_loop_simple(unsigned char *buffer,
                                                       const unsigned char *g1,
                                                       const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_simple(value buffer, value g1, value g2) {
  rustc_bls12_381_pairing_miller_loop_simple(Bytes_val(buffer), Bytes_val(g1),
                                             Bytes_val(g2));
  return Val_unit;
}

extern void rustc_bls12_381_pairing(unsigned char *buffer,
                                    const unsigned char *g1,
                                    const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_pairing(value buffer,
                                             value g1,
                                             value g2) {
  rustc_bls12_381_pairing(Bytes_val(buffer), Bytes_val(g1), Bytes_val(g2));
  return Val_unit;
}

extern void rustc_bls12_381_unsafe_pairing_final_exponentiation(unsigned char *buffer,
                                                                const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_unsafe_pairing_final_exponentiation(value buffer, value x) {
  rustc_bls12_381_unsafe_pairing_final_exponentiation(Bytes_val(buffer), Bytes_val(x));
  return Val_unit;
}
