type t<'a> = NonEmpty('a, array<'a>)

let fromArray: array<'a> => option<t<'a>>

let toArray: t<'a> => array<'a>

module Codec: {
  open RescriptStruct

  let array: S.t<array<'a>> => S.t<t<'a>>
}
