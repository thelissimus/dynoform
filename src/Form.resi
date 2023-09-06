module Data: {
  open RescriptStruct

  type meta = {name: string}

  type element =
    | SelectSingle({selected: string, meta: meta})
    | SelectSingleOptional({selected: option<string>, meta: meta})
    | SelectMultiple({selected: NonEmptyArray.t<string>, meta: meta})
    | SelectMultipleOptional({selected: array<string>, meta: meta})
    | Checkbox({checked: bool, meta: meta})
    | Text({content: string, meta: meta})
    | TextOptional({content: option<string>, meta: meta})
    | Textarea({content: string, meta: meta})
    | TextareaOptional({content: option<string>, meta: meta})
    | Number({number: float, meta: meta})
    | NumberOptional({number: option<float>, meta: meta})
    | Date({date: Js.Date.t, meta: meta})
    | DateOptional({date: option<Js.Date.t>, meta: meta})
    | Photo({file: Webapi.File.t, meta: meta})
    | PhotoOptional({file: option<Webapi.File.t>, meta: meta})
    | File({file: Webapi.File.t, meta: meta})
    | FileOptional({file: option<Webapi.File.t>, meta: meta})

  type group = {
    name: string,
    elements: array<element>,
  }

  type form = {
    name: string,
    groups: array<group>,
  }

  module Codec: {
    let meta: S.t<meta>
    let element: S.t<element>
    let group: S.t<group>
    let form: S.t<form>
  }
}

module Blueprint: {
  open RescriptStruct

  type meta = {
    name: string,
    label: string,
    description: string,
    mustConfirm: bool,
    required: bool,
  }

  type selectOption = {
    label: string,
    value: string,
  }

  type element =
    | SelectSingle({placeholder: string, options: array<selectOption>, meta: meta})
    | SelectMultiple({placeholder: string, options: array<selectOption>, meta: meta})
    | Checkbox({meta: meta})
    | Text({placeholder: string, meta: meta})
    | Textarea({placeholder: string, meta: meta})
    | Number({placeholder: string, meta: meta})
    | Date({placeholder: string, meta: meta})
    | Photo({meta: meta})
    | File({accept: array<string>, meta: meta})

  type group = {
    name: string,
    order: int,
    description: string,
    elements: NonEmptyArray.t<element>,
  }

  type form = {
    name: string,
    description: string,
    groups: NonEmptyArray.t<group>,
  }

  module Codec: {
    let meta: S.t<meta>
    let selectOption: S.t<selectOption>
    let element: S.t<element>
    let group: S.t<group>
    let form: S.t<form>
  }
}

module type Interpreter = {
  type output

  let interpret: Blueprint.element => output
}
