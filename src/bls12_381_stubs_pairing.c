#include <assert.h>
#include <caml/bigarray.h>
#include <caml/custom.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <inttypes.h>
#include <stdbool.h>

// Miller loop interfaces
extern void rustc_bls12_381_pairing_miller_loop_simple(unsigned char *buffer,
                                                       const unsigned char *g1,
                                                       const unsigned char *g2);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_simple(value buffer, value g1, value g2) {
  CAMLparam3(buffer, g1, g2);
  rustc_bls12_381_pairing_miller_loop_simple(Bytes_val(buffer), Bytes_val(g1),
                                             Bytes_val(g2));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_pairing_miller_loop_2(unsigned char *buffer,
                                                  const unsigned char *g1_1,
                                                  const unsigned char *g1_2,
                                                  const unsigned char *g2_1,
                                                  const unsigned char *g2_2);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_2(value buffer,
                                                 value g1_1, value g1_2,
                                                 value g2_1, value g2_2) {
  CAMLparam5(buffer, g1_1, g1_2, g2_1, g2_2);
  rustc_bls12_381_pairing_miller_loop_2(Bytes_val(buffer),
                                        Bytes_val(g1_1), Bytes_val(g1_2),
                                        Bytes_val(g2_1), Bytes_val(g2_2));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_pairing_miller_loop_3(
    unsigned char *buffer, const unsigned char *g1_1, const unsigned char *g1_2,
    const unsigned char *g1_3, const unsigned char *g2_1,
    const unsigned char *g2_2, const unsigned char *g2_3);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_3_native(value buffer, value g1_1, value g1_2, value g1_3, value g2_1, value g2_2, value g2_3) {
  CAMLparam5(buffer, g1_1, g1_2, g1_3, g2_1);
  CAMLxparam2(g2_2, g2_3);
  rustc_bls12_381_pairing_miller_loop_3(Bytes_val(buffer), Bytes_val(g1_1),
                                        Bytes_val(g1_2), Bytes_val(g1_3), Bytes_val(g2_1),
                                        Bytes_val(g2_2), Bytes_val(g2_3));
  CAMLreturn(Val_unit);
}

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_3_bytecode(value *argv, int argn) {
  CAMLparamN(argv, argn);
  rustc_bls12_381_pairing_miller_loop_3(
                                        Bytes_val(argv[0]), Bytes_val(argv[1]), Bytes_val(argv[2]), Bytes_val(argv[3]),
      Bytes_val(argv[4]), Bytes_val(argv[5]), Bytes_val(argv[6]));
  CAMLreturn(Val_unit);
}

extern CAMLprim value rustc_bls12_381_pairing_miller_loop_4(
    unsigned char *buffer, const unsigned char *g1_1, const unsigned char *g1_2,
    const unsigned char *g1_3, const unsigned char *g1_4, const unsigned char *g2_1,
    const unsigned char *g2_2, const unsigned char *g2_3, const unsigned char *g2_4);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_4_native(value buffer, value g1_1, value g1_2, value g1_3, value g1_4, value g2_1, value g2_2,
                                                                  value g2_3, value g2_4) {
  CAMLparam5(buffer, g1_1, g1_2, g1_3, g1_4);
  CAMLxparam4(g2_1, g2_2, g2_3, g2_4);
  rustc_bls12_381_pairing_miller_loop_4(Bytes_val(buffer), Bytes_val(g1_1), Bytes_val(g1_2), Bytes_val(g1_3), Bytes_val(g1_4),
                                        Bytes_val(g2_1), Bytes_val(g2_2), Bytes_val(g2_3), Bytes_val(g2_4));
  CAMLreturn(Val_unit);
}

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_4_bytecode(value *argv,
                                                                    int argn) {
  CAMLparamN(argv, argn);
  rustc_bls12_381_pairing_miller_loop_4(Bytes_val(argv[0]), Bytes_val(argv[1]),
                                        Bytes_val(argv[2]), Bytes_val(argv[3]),
                                        Bytes_val(argv[4]), Bytes_val(argv[5]),
                                        Bytes_val(argv[6]), Bytes_val(argv[7]),
                                        Bytes_val(argv[7]));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_pairing_miller_loop_5(
    unsigned char *buffer, const unsigned char *g1_1, const unsigned char *g1_2,
    const unsigned char *g1_3, const unsigned char *g1_4, const unsigned char *g1_5,
    const unsigned char *g2_1, const unsigned char *g2_2,
    const unsigned char *g2_3, const unsigned char *g2_4, const unsigned char *g2_5);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_5_native(value buffer, value g1_1, value g1_2, value g1_3, value g1_4, value g1_5, value g2_1,
                                                        value g2_2, value g2_3, value g2_4, value g2_5) {
  CAMLparam5(buffer, g1_1, g1_2, g1_3, g1_4);
  CAMLxparam5(g1_5, g2_1, g2_2, g2_3, g2_4);
  CAMLxparam1(g2_5);
  rustc_bls12_381_pairing_miller_loop_5(
      Bytes_val(buffer), Bytes_val(g1_1), Bytes_val(g1_2), Bytes_val(g1_3),
      Bytes_val(g1_4), Bytes_val(g1_5), Bytes_val(g2_1), Bytes_val(g2_2), Bytes_val(g2_3),
      Bytes_val(g2_4), Bytes_val(g2_5));
  CAMLreturn(Val_unit);
}

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_5_bytecode(value *argv,
                                                                    int argn) {
  CAMLparamN(argv, argn);
  rustc_bls12_381_pairing_miller_loop_5(
      Bytes_val(argv[0]), Bytes_val(argv[1]), Bytes_val(argv[2]),
      Bytes_val(argv[3]), Bytes_val(argv[4]), Bytes_val(argv[5]),
      Bytes_val(argv[6]), Bytes_val(argv[7]), Bytes_val(argv[8]), Bytes_val(argv[9]), Bytes_val(argv[10]));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_pairing_miller_loop_6(
    unsigned char *buffer, const unsigned char *g1_1, const unsigned char *g1_2,
    const unsigned char *g1_3, const unsigned char *g1_4,
    const unsigned char *g1_5, const unsigned char *g1_6, const unsigned char *g2_1,
    const unsigned char *g2_2, const unsigned char *g2_3,
    const unsigned char *g2_4, const unsigned char *g2_5, const unsigned char *g2_6);

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_6_native(value buffer, value g1_1, value g1_2, value g1_3, value g1_4, value g1_5, value g1_6,
                                                        value g2_1, value g2_2, value g2_3, value g2_4, value g2_5, value g2_6) {
  CAMLparam5(buffer, g1_1, g1_2, g1_3, g1_4);
  CAMLxparam5(g1_5, g1_6, g2_1, g2_2, g2_3);
  CAMLxparam3(g2_4, g2_5, g2_6);
  rustc_bls12_381_pairing_miller_loop_6(
      Bytes_val(buffer), Bytes_val(g1_1), Bytes_val(g1_2), Bytes_val(g1_3),
      Bytes_val(g1_4), Bytes_val(g1_5), Bytes_val(g1_6), Bytes_val(g2_1), Bytes_val(g2_2),
      Bytes_val(g2_3), Bytes_val(g2_4), Bytes_val(g2_5), Bytes_val(g2_6));
  CAMLreturn(Val_unit);
}

CAMLprim value ml_librustc_bls12_381_pairing_miller_loop_6_bytecode(value *argv,
                                                          int argn) {
  CAMLparamN(argv, argn);
  rustc_bls12_381_pairing_miller_loop_6(
      Bytes_val(argv[0]), Bytes_val(argv[1]), Bytes_val(argv[2]),
      Bytes_val(argv[3]), Bytes_val(argv[4]), Bytes_val(argv[5]),
      Bytes_val(argv[6]), Bytes_val(argv[7]), Bytes_val(argv[8]),
      Bytes_val(argv[9]), Bytes_val(argv[10]), Bytes_val(argv[11]), Bytes_val(argv[12]));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_pairing(unsigned char *buffer,
                                    const unsigned char *g1,
                                    const unsigned char *g2);


CAMLprim value ml_librustc_bls12_381_pairing(value buffer,
                                   value g1,
                                   value g2) {
  CAMLparam3(buffer, g1, g2);
  rustc_bls12_381_pairing(Bytes_val(buffer), Bytes_val(g1), Bytes_val(g2));
  CAMLreturn(Val_unit);
}

extern void rustc_bls12_381_unsafe_pairing_final_exponentiation(unsigned char *buffer,
                                                                const unsigned char *x);

CAMLprim value ml_librustc_bls12_381_unsafe_pairing_final_exponentiation(value buffer, value x) {
  CAMLparam2(buffer, x);
  rustc_bls12_381_unsafe_pairing_final_exponentiation(Bytes_val(buffer), Bytes_val(x));
  CAMLreturn(Val_unit);
}
