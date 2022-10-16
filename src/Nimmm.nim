import nimmkl/[common, mulColMajor]
import std/[complex, random]

proc moduleInit() =
  random.randomize()

moduleInit()


# ME = alias for matrix element type
type
  ME* = SomeElementType

type
  Matrix*[T: ME] = ref object
    rows: int
    cols: int
    data: seq[T]

  Matrix64* = Matrix[float64]
  Matrix32* = Matrix[float32]
  MatrixC64* = Matrix[Complex64]
  MatrixC32* = Matrix[Complex32]

proc idx(row, col, numRows: int): int {. inline .} =
  col * numRows + row

proc create[T: ME](rows, cols: int, a: seq[T]): Matrix[T] =
  result = Matrix[T](rows: rows, cols: cols)
  shallowCopy(result.data, a)

proc matrix*[T: ME](rows, cols: int): Matrix[T] =
  create[T](rows, cols, newSeq[T](rows * cols))

proc matrix64*(rows, cols: int): Matrix64 =
  matrix[float64](rows, cols)

proc matrix32*(rows, cols: int): Matrix32 =
  matrix[float32](rows, cols)

proc matrixC64*(rows, cols: int): MatrixC64 =
  matrix[Complex64](rows, cols)

proc matrixC32*(rows, cols: int): MatrixC32 =
  matrix[Complex32](rows, cols)

proc one[T](): T =
  when T is float64:
    result = 1.0'f64
  when T is float32:
    result = 1.0'f32
  when T is Complex64:
    result = complex64(1.0'f64)
  when T is Complex32:
    result = complex32(1.0'f32)

proc eye*[T: ME](n: int): Matrix[T] =
  result = matrix[T](n, n)
  for i in countup(0, n - 1):
    result[i, i] = one[T]()

proc randNormal*[T: ME](rows, cols: int, mu : float = 0.0; sigma : float = 1.0): Matrix[T] =
  result = matrix[T](rows, cols)
  when T is SomeFloat:
    for i in countup(0, (rows * cols) - 1):
      result.data[i] = T(random.gauss(mu, sigma))
  when T is Complex64:
    for i in countup(0, (rows * cols) - 1):
      result.data[i] = complex64(random.gauss(mu, sigma), random.gauss(mu, sigma))
  when T is Complex32:
    for i in countup(0, (rows * cols) - 1):
      result.data[i] = complex32(random.gauss(mu, sigma), random.gauss(mu, sigma))

proc dim*[T: ME](a: Matrix[T]): tuple[rows, cols: int] =
  (a.rows, a.cols)

proc `==`*[T: ME](a, b: Matrix[T]): bool =
  a.rows == b.rows and a.cols == b.cols and a.data == b.data

proc `$`*[T: ME](a: Matrix[T]): string =
  result = $(a.data)

proc `[]`*[T: ME](a: Matrix[T], i, j: int): T {. inline .} =
  a.data[idx(i, j, a.rows)]

proc `[]=`*[T: ME](a: var Matrix[T], i, j: int, val: T) {. inline .} =
  a.data[idx(i, j, a.rows)] = val

proc `*`*[T: ME](a, b: Matrix[T]): Matrix[T]  =
  let m = a.rows
  let n = b.cols
  let k = a.cols
  result = create[T](m, n, mul[T](m, n, k, a.data, b.data))

# todo : + and -
