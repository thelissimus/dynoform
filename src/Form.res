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
  description: string,
  title: string,
  placeholder: string,
  mustConfirm: bool,
}

type element =
  | SelectSingle({selected: option<string>, options: array<selectOption>, meta: elementMeta})
  | SelectSingleRequired({selected: string, options: array<selectOption>, meta: elementMeta})
  | SelectMultiple({selected: array<string>, options: array<selectOption>, meta: elementMeta})
  | SelectMultipleRequired({
      selected: NonEmptyArray.t<string>,
      options: array<selectOption>,
      meta: elementMeta,
    })
  | Photo({file: option<Webapi.File.t>, meta: elementMeta})
  | PhotoRequired({file: Webapi.File.t, meta: elementMeta})
  | Checkbox({checked: bool, meta: elementMeta})
  | Text({content: option<string>, meta: elementMeta})
  | TextRequired({content: string, meta: elementMeta})
  | Textarea({content: option<string>, meta: elementMeta})
  | TextareaRequired({content: string, meta: elementMeta})
  | Number({number: option<float>, meta: elementMeta})
  | NumberRequired({number: float, meta: elementMeta})
  | Date({date: option<Js.Date.t>, meta: elementMeta})
  | DateRequired({date: Js.Date.t, meta: elementMeta})
  | File({file: option<Webapi.File.t>, meta: elementMeta})
  | FileRequired({file: Webapi.File.t, meta: elementMeta})
