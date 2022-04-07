import std/algorithm
import sequtils

proc select(x: seq[int], k: int, order: SortOrder = SortOrder.Descending): int =
  if x.len <= 9:
    return sorted(x, system.cmp[int], order)[k]

  var slices = newSeq[array[5, int]]()
  for i in 0 .. (x.len div 5):
    var slice: array[5, int]

    for j in 0 ..< 5:
      if i * 5 + j < x.len:
        slice[j] = x[i * 5 + j]
      else:
        slice[j] = x[x.len - 1]

    sort(slice, system.cmp[int], order)
    slices.add(slice)

  var
    y = map(slices, proc (x: array[5, int]): int = x[2])
    a = select(y, y.len div 2, order)
    l = filter(x, proc (n: int): bool = a < n)
    s = filter(x, proc (n: int): bool = a > n)

  if k <= l.len:
    return select(l, k)
  elif l.len < k - 1:
    return select(s, k-l.len-1)
  else:
    return a

echo select(toSeq(1..1000), 2)
