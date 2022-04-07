import std/algorithm

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

    var se = sorted(slice, system.cmp[int], order)
    slices.add(se)

  echo slices
  return x.len

discard @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 23].select(3)
