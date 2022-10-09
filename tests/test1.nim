# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import std/complex
import unittest
import Nimmm


test "[2 x 2] * [2 x 2] float32 test for []= and *":
  var m1 = newMatrix[float32](2, 2)
  var m2 = newMatrix[float32](2, 2)

  m1[0, 0] = 55
  m1[0, 1] = 66
  m1[1, 0] = 77
  m1[1, 1] = 88

  m2[0, 0] = 99
  m2[0, 1] = 22
  m2[1, 0] = 11
  m2[1, 1] = 33

  let c = m1 * m2
  echo c

test "[2 x 2] * [2 x 1] Complex64 test for []= and *":
  var m1 = newMatrix[Complex64](2, 2)
  var m2 = newMatrix[Complex64](2, 1)

  m1[0, 0] = complex64(55, -1)
  m1[0, 1] = complex64(66, 1)
  m1[1, 0] = complex64(77, 0)
  m1[1, 1] = complex64(88, 2.5)

  m2[0, 0] = complex64(99, 0.33)
  m2[1, 0] = complex64(11, 0.7)

  let c = m1 * m2
  echo c

