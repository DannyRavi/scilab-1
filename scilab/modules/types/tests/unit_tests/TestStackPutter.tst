// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Scilab Enterprises - Calixte DENIZET
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
//
// <-- JVM MANDATORY -->

ilib_verbose(0);
if haveacompiler() then
  cd TMPDIR;
  mkdir("TestStackPutter");
  cd("TestStackPutter");
  jdk_home = getenv("JAVA_HOME", "");
  CFLAGS = "-I" + TMPDIR + "/TestStackPutter";
  CFLAGS = CFLAGS + " -I" + fullpath(SCI + "/modules/commons/src/jni");
  CFLAGS = CFLAGS + " -I" + fullpath(SCI + "/modules/jvm/includes");
  CFLAGS = CFLAGS + " -I" + fullpath(SCI + "/modules/types/includes");
  CFLAGS = CFLAGS + " -I" + fullpath(SCI + "/modules/types/includes");
  CFLAGS = CFLAGS + " -I" + jdk_home + "/include";
  copyfile(SCI + "/modules/types/tests/unit_tests/TestS2JJ2S.hxx", TMPDIR + "/TestStackPutter/TestS2JJ2S.hxx");
  copyfile(SCI + "/modules/types/tests/unit_tests/TestS2JJ2S.cpp", TMPDIR + "/TestStackPutter/TestS2JJ2S.cpp");
  copyfile(SCI + "/modules/types/tests/unit_tests/sci_testputter.cpp", TMPDIR + "/TestStackPutter/sci_testputter.cpp");

  WITHOUT_AUTO_PUTLHSVAR = %t;
  ilib_build("testputterlib",["testputter","sci_testputter"], ["sci_testputter.cpp" "TestS2JJ2S.cpp"], [], [], "", CFLAGS);
  exec loader.sce;
  d = [1 1; 10 10; 12 23; 23 17; 1 32; 56 1];
  for i=1:6
      a1 = rand(d(i, 1), d(i, 2));
      assert_checkequal(testputter(a1), a1);
      a2 = rand(d(i, 1), d(i, 2)) + %i * rand(d(i, 1), d(i, 2));
      assert_checkequal(testputter(a2), a2);
      a3 = rand(d(i, 1), d(i, 2)) <= 0.5;
      assert_checkequal(testputter(a3), a3);
      a4 = int8(128 * rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a4), a4);
      a5 = uint8(128 * rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a5), a5);
      a6 = int16(32768 * rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a6), a6);
      a7 = uint16(32768 * rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a7), a7);
      a8 = int32(2147483648 * rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a8), a8);
      a9 = uint32(2147483648 * rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a9), a9);
      a10 = string(rand(d(i, 1), d(i, 2)));
      assert_checkequal(testputter(a10), a10);
      a11 = sprand(d(i, 1), d(i, 2), 0.2);
      assert_checkequal(testputter(a11), a11);
      a12 = sprand(d(i, 1), d(i, 2), 0.2) + %i * a11;
      assert_checkequal(testputter(a12), a12);
      a13 = rand(d(i, 1), d(i, 2)) + rand(d(i, 1), d(i, 2)) * %s - rand(d(i, 1), d(i, 2)) * %s^2;
      assert_checkequal(testputter(a13), a13);
      a14 = rand(d(i, 1), d(i, 2)) + rand(d(i, 1), d(i, 2)) * %s - rand(d(i, 1), d(i, 2)) * %s^2 + %i * a13;
      assert_checkequal(testputter(a14), a14);
      a15 = mlist(['a' 'b' 'c' 'd' 'e'], a1, a2, a3, a10);
      assert_checkequal(testputter(a15), a15);
      a16 = tlist(['a' 'b' 'c' 'd' 'e'], a1, a2, a3, a10);
      assert_checkequal(testputter(a16), a16);
      a17 = list(a1, a2, a3, a10);
      assert_checkequal(testputter(a17), a17);
   end
end