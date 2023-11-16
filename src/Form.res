module Data = {
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

  module Codec = {
    open RescriptStruct

    let meta = S.object(s => {
      name: s.field("name", S.string),
    })->S.Object.strict

    @inline
    let discriminator = "kind"

    let element = S.union([
      S.object(s => {
        s.tag(discriminator, "SelectSingle")
        SelectSingle({
          selected: s.field("selected", S.string),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "SelectSingleOptional")
        SelectSingleOptional({
          selected: s.field("selected", S.option(S.string)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "SelectMultiple")
        SelectMultiple({
          selected: s.field("selected", S.array(S.string)->NonEmptyArray.Codec.array),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "SelectMultipleOptional")
        SelectMultipleOptional({
          selected: s.field("selected", S.array(S.string)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Checkbox")
        Checkbox({
          checked: s.field("checked", S.bool),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Text")
        Text({
          content: s.field("content", S.string),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "TextOptional")
        TextOptional({
          content: s.field("content", S.option(S.string)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Textarea")
        Textarea({
          content: s.field("content", S.string),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "TextareaOptional")
        TextareaOptional({
          content: s.field("content", S.option(S.string)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Number")
        Number({
          number: s.field("number", S.float),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "NumberOptional")
        NumberOptional({
          number: s.field("number", S.option(S.float)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Date")
        Date({
          date: s.field("date", S.string->S.String.datetime),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "DateOptional")
        DateOptional({
          date: s.field("date", S.option(S.string->S.String.datetime)),
          meta: s.field("meta", meta),
        })
      }),
      // TODO: Photo, File
    ])

    let group = S.object(s => {
      name: s.field("name", S.string),
      elements: s.field("elements", S.array(element)),
    })->S.Object.strict

    let form = S.object(s => {
      name: s.field("name", S.string),
      groups: s.field("groups", S.array(group)),
    })->S.Object.strict
  }
}

module Blueprint = {
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
    elements: array<element>,
  }

  type form = {
    name: string,
    description: string,
    groups: array<group>,
  }

  module Codec = {
    open RescriptStruct

    let meta = S.object(s => {
      name: s.field("name", S.string),
      label: s.field("label", S.string),
      description: s.field("description", S.string),
      mustConfirm: s.field("mustConfirm", S.bool),
      required: s.field("required", S.bool),
    })->S.Object.strict

    let selectOption = S.object(s => {
      value: s.field("value", S.string),
      label: s.field("label", S.string),
    })->S.Object.strict

    @inline
    let discriminator = "kind"

    let element = S.union([
      S.object(s => {
        s.tag(discriminator, "SelectSingle")
        SelectSingle({
          placeholder: s.field("placeholder", S.string),
          options: s.field("options", S.array(selectOption)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "SelectMultiple")
        SelectMultiple({
          placeholder: s.field("placeholder", S.string),
          options: s.field("options", S.array(selectOption)),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Checkbox")
        Checkbox({
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Text")
        Text({
          placeholder: s.field("placeholder", S.string),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Textarea")
        Textarea({
          placeholder: s.field("placeholder", S.string),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Number")
        Number({
          placeholder: s.field("placeholder", S.string),
          meta: s.field("meta", meta),
        })
      }),
      S.object(s => {
        s.tag(discriminator, "Date")
        Date({
          placeholder: s.field("placeholder", S.string),
          meta: s.field("meta", meta),
        })
      }),
      // TODO: Photo, File
    ])

    let group = S.object(s => {
      name: s.field("name", S.string),
      order: s.field("order", S.int),
      description: s.field("description", S.string),
      elements: s.field("elements", S.array(element)),
    })->S.Object.strict

    let form = S.object(s => {
      name: s.field("name", S.string),
      description: s.field("description", S.string),
      groups: s.field("groups", S.array(group)),
    })->S.Object.strict
  }
}

module type Interpreter = {
  type output

  let interpret: Blueprint.form => output
}
