type t<'a> = NonEmpty('a, array<'a>)

let fromArray: array<'a> => option<t<'a>>

let fromArrayUnsafe: array<'a> => t<'a>

let toArray: t<'a> => array<'a>

let map: (t<'a>, 'a => 'b) => t<'b>

let forEach: (t<'a>, 'a => unit) => unit

let traverseResult: (t<result<'a, 'e>>, 'a => result<'b, 'e>) => result<t<'b>, 'e>

let sequenceResult: t<result<'a, 'e>> => result<t<'a>, 'e>

module Codec: {
  open RescriptStruct

  let array: S.t<array<'a>> => S.t<t<'a>>
}
