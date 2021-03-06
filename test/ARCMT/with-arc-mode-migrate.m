// RUN: %clang_cc1 -fobjc-nonfragile-abi -fsyntax-only -fobjc-arc -x objective-c %s.result
// RUN: %clang_cc1 -arcmt-migrate -arcmt-migrate-directory %t -fobjc-nonfragile-abi -fsyntax-only -fobjc-arc %s
// RUN: c-arcmt-test -arcmt-migrate-directory %t | arcmt-test -verify-transformed-files %s.result
// RUN: rm -rf %t

@protocol NSObject
- (oneway void)release;
@end

void test1(id p) {
  [p release];
}
