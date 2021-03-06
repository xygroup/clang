// Test this without pch.
// RUN: %clang_cc1 -fblocks -triple x86_64-apple-darwin11 -fobjc-nonfragile-abi -fobjc-arc -include %S/Inputs/arc.h -fsyntax-only -emit-llvm-only %s

// Test with pch.
// RUN: %clang_cc1 -emit-pch -fblocks -triple x86_64-apple-darwin11 -fobjc-nonfragile-abi -fobjc-arc -x objective-c-header -o %t %S/Inputs/arc.h
// RUN: %clang_cc1 -fblocks -triple x86_64-apple-darwin11 -fobjc-nonfragile-abi -fobjc-arc -include-pch %t -fsyntax-only -emit-llvm-only %s 

// Test error when pch's -fobjc-arc state is different.
// RUN: %clang_cc1 -fblocks -triple x86_64-apple-darwin11 -fobjc-nonfragile-abi -include-pch %t -fsyntax-only -emit-llvm-only %s 2>&1 | FileCheck -check-prefix=ERR1 %s 
// RUN: %clang_cc1 -emit-pch -fblocks -triple x86_64-apple-darwin11 -fobjc-nonfragile-abi -x objective-c-header -o %t %S/Inputs/arc.h
// RUN: %clang_cc1 -fblocks -triple x86_64-apple-darwin11 -fobjc-nonfragile-abi -fobjc-arc -include-pch %t -fsyntax-only -emit-llvm-only %s 2>&1 | FileCheck -check-prefix=ERR2 %s

array0 a0;
array1 a1;

// CHECK-ERR1: PCH file was compiled with automated reference counting, which is currently disabled
// CHECK-ERR2: PCH file was compiled without automated reference counting, which is currently enabled
