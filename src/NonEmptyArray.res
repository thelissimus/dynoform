@@uncurried

type t<'a> = NonEmpty('a, array<'a>)

let fromArray = xs => xs[0]->Option.map(x => NonEmpty(x, Array.sliceToEnd(xs, ~start=1)))

let fromArrayUnsafe = xs => NonEmpty(xs->Array.getUnsafe(0), xs->Array.sliceToEnd(~start=1))

let toArray = xs =>
  switch xs {
  | NonEmpty(x, rest) => [x]->Array.concat(rest)
  }

let map = (xs, f) =>
  switch xs {
  | NonEmpty(x, rest) => NonEmpty(f(x), rest->Array.map(f))
  }

let forEach = (xs, f) =>
  switch xs {
  | NonEmpty(x, rest) => {
      f(x)
      rest->Array.forEach(f)
    }
  }

let traverseResult = (xs: t<result<'a, 'e>>, f: 'a => result<'b, 'e>): result<t<'b>, 'e> =>
  switch xs {
  | NonEmpty(x, rest) =>
    switch (
      Result.flatMap(x, f),
      Array.reduce(rest, Ok([]), (acc, curr) =>
        acc->Result.flatMap(arr => curr->Result.flatMap(f)->Result.map(v => [v]->Array.concat(arr)))
      ),
    ) {
    | (Ok(v), Ok(t)) => Ok(NonEmpty(v, t))
    | (Error(e), _) | (_, Error(e)) => Error(e)
    }
  }

let sequenceResult = xs => xs->traverseResult(x => Ok(x))

module Codec = {
  open RescriptStruct

  let array = struct =>
    struct->S.transform(s => {
      parser: array =>
        switch array->fromArray {
        | Some(ne) => ne
        | None => s.fail("supplied array is empty")
        },
      serializer: toArray,
    })
}
