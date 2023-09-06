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

    let meta = S.object(o => {
      name: o->S.field("name", S.string()),
    })->S.Object.strict

    @inline
    let discriminator = "kind"

    let element = S.union([
      S.object(o => {
        o->S.field(discriminator, S.literal(String("SelectSingle")))->ignore
        SelectSingle({
          selected: o->S.field("selected", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("SelectSingleOptional")))->ignore
        SelectSingleOptional({
          selected: o->S.field("selected", S.option(S.string())),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("SelectMultiple")))->ignore
        SelectMultiple({
          selected: o->S.field("selected", S.array(S.string())->NonEmptyArray.Codec.array),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("SelectMultipleOptional")))->ignore
        SelectMultipleOptional({
          selected: o->S.field("selected", S.array(S.string())),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Checkbox")))->ignore
        Checkbox({
          checked: o->S.field("checked", S.bool()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Text")))->ignore
        Text({
          content: o->S.field("content", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("TextOptional")))->ignore
        TextOptional({
          content: o->S.field("content", S.option(S.string())),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Textarea")))->ignore
        Textarea({
          content: o->S.field("content", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("TextareaOptional")))->ignore
        TextareaOptional({
          content: o->S.field("content", S.option(S.string())),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Number")))->ignore
        Number({
          number: o->S.field("number", S.float()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("NumberOptional")))->ignore
        NumberOptional({
          number: o->S.field("number", S.option(S.float())),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Date")))->ignore
        Date({
          date: o->S.field("date", S.string()->S.String.datetime()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("DateOptional")))->ignore
        DateOptional({
          date: o->S.field("date", S.option(S.string()->S.String.datetime())),
          meta: o->S.field("meta", meta),
        })
      }),
      // TODO: Photo, File
    ])

    let group = S.object(o => {
      name: o->S.field("name", S.string()),
      elements: o->S.field("elements", S.array(element)),
    })->S.Object.strict

    let form = S.object(o => {
      name: o->S.field("name", S.string()),
      groups: o->S.field("groups", S.array(group)),
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
    elements: NonEmptyArray.t<element>,
  }

  type form = {
    name: string,
    description: string,
    groups: NonEmptyArray.t<group>,
  }

  module Codec = {
    open RescriptStruct

    let meta = S.object(o => {
      name: o->S.field("name", S.string()),
      label: o->S.field("label", S.string()),
      description: o->S.field("description", S.string()),
      mustConfirm: o->S.field("mustConfirm", S.bool()),
      required: o->S.field("required", S.bool()),
    })->S.Object.strict

    let selectOption = S.object(o => {
      value: o->S.field("value", S.string()),
      label: o->S.field("label", S.string()),
    })->S.Object.strict

    @inline
    let discriminator = "kind"

    let element = S.union([
      S.object(o => {
        o->S.field(discriminator, S.literal(String("SelectSingle")))->ignore
        SelectSingle({
          placeholder: o->S.field("placeholder", S.string()),
          options: o->S.field("options", S.array(selectOption)),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("SelectMultiple")))->ignore
        SelectMultiple({
          placeholder: o->S.field("placeholder", S.string()),
          options: o->S.field("options", S.array(selectOption)),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Checkbox")))->ignore
        Checkbox({
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Text")))->ignore
        Text({
          placeholder: o->S.field("placeholder", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Textarea")))->ignore
        Textarea({
          placeholder: o->S.field("placeholder", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Number")))->ignore
        Number({
          placeholder: o->S.field("placeholder", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      S.object(o => {
        o->S.field(discriminator, S.literal(String("Date")))->ignore
        Date({
          placeholder: o->S.field("placeholder", S.string()),
          meta: o->S.field("meta", meta),
        })
      }),
      // TODO: Photo, File
    ])

    let group = S.object(o => {
      name: o->S.field("name", S.string()),
      order: o->S.field("order", S.int()),
      description: o->S.field("description", S.string()),
      elements: o->S.field("elements", S.array(element)->NonEmptyArray.Codec.array),
    })->S.Object.strict

    let form = S.object(o => {
      name: o->S.field("name", S.string()),
      description: o->S.field("description", S.string()),
      groups: o->S.field("groups", S.array(group)->NonEmptyArray.Codec.array),
    })->S.Object.strict
  }
}

module type Interpreter = {
  type output

  let interpret: Blueprint.form => output
}
