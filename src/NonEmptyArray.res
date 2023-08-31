type t<'a> = NonEmpty('a, array<'a>)

let fromArray = xs =>
  if Array.length(xs) == 0 {
    None
  } else {
    Some(NonEmpty(Array.getUnsafe(xs, 0), Array.sliceToEnd(xs, ~start=1)))
  }

let toArray = (xs: t<'a>) =>
  switch xs {
  | NonEmpty(x, rest) => [x]->Array.concat(rest)
  }
