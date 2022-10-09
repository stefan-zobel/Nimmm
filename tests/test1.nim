# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import Nimmm
test "first for test []= and *":
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
