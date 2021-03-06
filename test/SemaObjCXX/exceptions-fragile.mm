// RUN: %clang_cc1 -fcxx-exceptions -fexceptions -fsyntax-only -verify %s 

@interface NSException @end
void opaque();

namespace test0 {
  void test() {
    try {
    } catch (NSException *e) { // expected-warning {{can not catch an exception thrown with @throw in C++ in the non-unified exception model}}
    }
  }
}
