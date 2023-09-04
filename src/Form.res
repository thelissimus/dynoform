type status =
  | Active
  | Inactive

type selectOption = {
  label: string,
  value: string,
}

type elementMeta = {
  status: status,
  name: string,
  title: string,
  description: string,
  mustConfirm: bool,
}

type element =
  | SelectSingleOptional({
      selected: option<string>,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | SelectSingle({
      selected: string,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | SelectMultipleOptional({
      selected: array<string>,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | SelectMultiple({
      selected: NonEmptyArray.t<string>,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | PhotoOptional({file: option<Webapi.File.t>, meta: elementMeta})
  | Photo({file: Webapi.File.t, meta: elementMeta})
  | Checkbox({checked: bool, meta: elementMeta})
  | TextOptional({content: option<string>, placeholder: string, meta: elementMeta})
  | Text({content: string, placeholder: string, meta: elementMeta})
  | TextareaOptional({content: option<string>, placeholder: string, meta: elementMeta})
  | Textarea({content: string, placeholder: string, meta: elementMeta})
  | NumberOptional({number: option<float>, placeholder: string, meta: elementMeta})
  | Number({number: float, placeholder: string, meta: elementMeta})
  | DateOptional({date: option<Js.Date.t>, placeholder: string, meta: elementMeta})
  | Date({date: Js.Date.t, placeholder: string, meta: elementMeta})
  | FileOptional({file: option<Webapi.File.t>, meta: elementMeta})
  | File({file: Webapi.File.t, meta: elementMeta})

type group = {
  status: status,
  name: string,
  description: string,
  elements: array<element>,
}
