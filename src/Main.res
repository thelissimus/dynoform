open Form

let eval = es =>
  es->Array.forEach(e =>
    switch e {
    | SelectSingle(_) => ()
    | SelectSingleRequired(_) => ()
    | SelectMultiple(_) => ()
    | SelectMultipleRequired(_) => ()
    | Photo(_) => ()
    | PhotoRequired(_) => ()
    | Checkbox(_) => ()
    | Text(_) => ()
    | TextRequired(_) => ()
    | Textarea(_) => ()
    | TextareaRequired(_) => ()
    | Number(_) => ()
    | NumberRequired(_) => ()
    | Date(_) => ()
    | DateRequired(_) => ()
    | File(_) => ()
    | FileRequired(_) => ()
    }
  )
