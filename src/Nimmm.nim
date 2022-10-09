import nimmkl, nimmkl/[common, mulColMajor]

type
  ME* = SomeElementType

type
  Matrix*[T: ME] = ref object
    rows: int
    cols: int
    data: seq[T]

proc idx(row, col, numRows: int): int {. inline .} =
  col * numRows + row

proc newMatrix*[T: ME](rows, cols: int): Matrix[T] =
  result = Matrix[T](rows: rows, cols: cols)
  result.data = newSeq[T](rows * cols)

proc newMatrix[T: ME](rows, cols: int, a: seq[T]): Matrix[T] =
  result = Matrix[T](rows: rows, cols: cols)
  result.data = a

proc `$`*[T: ME](a: Matrix[T]): string =
  result = $(a.data)

proc `*`*[T: ME](a, b: Matrix[T]): Matrix[T]  =
  let m = a.rows
  let n = b.cols
  let k = a.cols
  result = newMatrix[T](m, n, mul[T](m, n, k, a.data, b.data))

proc `[]=`*[T: ME](m: var Matrix[T], i, j: int, val: T) =
  m.data[idx(i, j, m.rows)] = val
