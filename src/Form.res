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
  | SelectSingle({
      selected: option<string>,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | SelectSingleRequired({
      selected: string,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | SelectMultiple({
      selected: array<string>,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | SelectMultipleRequired({
      selected: NonEmptyArray.t<string>,
      placeholder: string,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | Photo({file: option<Webapi.File.t>, meta: elementMeta})
  | PhotoRequired({file: Webapi.File.t, meta: elementMeta})
  | Checkbox({checked: bool, meta: elementMeta})
  | Text({content: option<string>, placeholder: string, meta: elementMeta})
  | TextRequired({content: string, placeholder: string, meta: elementMeta})
  | Textarea({content: option<string>, placeholder: string, meta: elementMeta})
  | TextareaRequired({content: string, placeholder: string, meta: elementMeta})
  | Number({number: option<float>, placeholder: string, meta: elementMeta})
  | NumberRequired({number: float, placeholder: string, meta: elementMeta})
  | Date({date: option<Js.Date.t>, placeholder: string, meta: elementMeta})
  | DateRequired({date: Js.Date.t, placeholder: string, meta: elementMeta})
  | File({file: option<Webapi.File.t>, meta: elementMeta})
  | FileRequired({file: Webapi.File.t, meta: elementMeta})

type group = {
  status: status,
  name: string,
  description: string,
  elements: array<element>,
}
