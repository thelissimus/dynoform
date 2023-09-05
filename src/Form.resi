module Data: {
  open RescriptStruct

  type meta = {name: string}

  type t =
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

  module Codec: {
    let meta: S.t<meta>
    let t: S.t<t>
  }
}

module Blueprint: {
  open RescriptStruct

  type meta = {
    enabled: bool,
    name: string,
    title: string,
    description: string,
    mustConfirm: bool,
  }

  type selectOption = {
    label: string,
    value: string,
  }

  type t =
    | SelectSingle({placeholder: string, options: array<selectOption>, meta: meta})
    | SelectSingleOptional({placeholder: string, options: array<selectOption>, meta: meta})
    | SelectMultiple({placeholder: string, options: array<selectOption>, meta: meta})
    | SelectMultipleOptional({placeholder: string, options: array<selectOption>, meta: meta})
    | Checkbox({meta: meta})
    | Text({placeholder: string, meta: meta})
    | TextOptional({placeholder: string, meta: meta})
    | Textarea({placeholder: string, meta: meta})
    | TextareaOptional({placeholder: string, meta: meta})
    | Number({placeholder: string, meta: meta})
    | NumberOptional({placeholder: string, meta: meta})
    | Date({placeholder: string, meta: meta})
    | DateOptional({placeholder: string, meta: meta})
    | Photo({meta: meta})
    | PhotoOptional({meta: meta})
    | File({accept: array<string>, meta: meta})
    | FileOptional({accept: array<string>, meta: meta})

  module Codec: {
    let meta: S.t<meta>
    let selectOption: S.t<selectOption>
    let t: S.t<t>
  }
}
