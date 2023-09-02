type t<'a> = NonEmpty('a, array<'a>)

let fromArray = xs => xs[0]->Option.map(x => NonEmpty(x, Array.sliceToEnd(xs, ~start=1)))

let toArray = xs =>
  switch xs {
  | NonEmpty(x, rest) => [x]->Array.concat(rest)
  }
