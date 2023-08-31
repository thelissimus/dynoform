type t<'a> = NonEmpty('a, array<'a>)

let fromArray: array<'a> => option<t<'a>>

let toArray: t<'a> => array<'a>
