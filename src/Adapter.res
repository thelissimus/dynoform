@@uncurried

let arrayTraverseResult = (xs: array<result<'a, 'e>>, f: 'a => result<'b, 'e>): result<
  array<'b>,
  'e,
> =>
  xs->Array.reduce(Ok([]), (acc, curr) =>
    acc->Result.flatMap(arr => curr->Result.flatMap(f)->Result.map(v => [v]->Array.concat(arr)))
  )

module ForReact: Form.Interpreter with type output = React.element = {
  open Form.Blueprint

  type output = React.element

  type withKey<'a> = {
    key: string,
    value: 'a,
  }

  let interpretElement = ({key, value: element}) =>
    switch element {
    | SelectSingle({options, placeholder, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <select name multiple=false required>
          {options
          ->Array.mapWithIndex(({label, value}, i) => <option label value key={i->Int.toString} />)
          ->Array.concat([
            <option label=placeholder selected=true disabled=true hidden=true key="default" />,
          ])
          ->React.array}
        </select>
      </React.Fragment>

    | SelectMultiple({options, placeholder, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <select name multiple=true required>
          {options
          ->Array.mapWithIndex(({label, value}, i) => <option label value key={i->Int.toString} />)
          ->Array.concat([
            <option label=placeholder selected=true disabled=true hidden=true key="default" />,
          ])
          ->React.array}
        </select>
      </React.Fragment>

    | Checkbox({meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <input name type_="checkbox" required />
      </React.Fragment>

    | Text({placeholder, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <input name type_="text" placeholder required />
      </React.Fragment>

    | Textarea({placeholder, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <textarea name placeholder required />
      </React.Fragment>

    | Number({placeholder, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <input name type_="number" placeholder required />
      </React.Fragment>

    | Date({placeholder, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <input name type_="date" placeholder required />
      </React.Fragment>

    | Photo({meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <input name type_="image" required />
      </React.Fragment>

    | File({accept, meta: {name, label, required}}) =>
      <React.Fragment key>
        <label htmlFor=name> {label->React.string} </label>
        <input name type_="file" accept={accept->Array.joinWith(",")} required />
      </React.Fragment>
    }

  let interpretGroup = ({key, value: group}) =>
    <section key>
      {group.elements
      ->Array.mapWithIndex((e, i) => interpretElement({key: i->Int.toString, value: e}))
      ->React.array}
    </section>

  type evalErr = RequirementNotFulfuilled

  let interpret = f =>
    <form
      onSubmit={e => {
        module FD = Form.Data

        ReactEvent.Form.preventDefault(e)

        let res: FD.form = {
          name: f.name,
          groups: f.groups->Array.map(({name, elements}): FD.group => {
            name,
            elements: elements
            ->Array.map(elem => {
              let get = (name, prop) =>
                ReactEvent.Form.target(e)["elements"]
                ->Js.Dict.get(name)
                ->Option.flatMap(o => o->Js.Dict.get(prop))
              let getVal = name => name->get("value")
              let getChecked = name => name->get("checked")

              switch elem {
              | SelectSingle({meta: {name, required}}) =>
                if required {
                  getVal(name)->Option.mapWithDefault(
                    Error(RequirementNotFulfuilled),
                    v => Ok(FD.SelectSingle({selected: v, meta: {name: name}})),
                  )
                } else {
                  getVal(name)->Option.mapWithDefault(
                    Error(RequirementNotFulfuilled),
                    v => Ok(FD.SelectSingleOptional({selected: Some(v), meta: {name: name}})),
                  )
                }
              | Text({meta: {name, required}}) =>
                if required {
                  getVal(name)->Option.mapWithDefault(
                    Error(RequirementNotFulfuilled),
                    v => Ok(FD.Text({content: v, meta: {name: name}})),
                  )
                } else {
                  getVal(name)->Option.mapWithDefault(
                    Error(RequirementNotFulfuilled),
                    v => Ok(FD.TextOptional({content: Some(v), meta: {name: name}})),
                  )
                }
              | Checkbox({meta: {name, required}}) =>
                if required {
                  getChecked(name)->Option.mapWithDefault(
                    Error(RequirementNotFulfuilled),
                    v => Ok(FD.Checkbox({checked: v, meta: {name: name}})),
                  )
                } else {
                  getChecked(name)->Option.mapWithDefault(
                    Error(RequirementNotFulfuilled),
                    v => Ok(FD.Checkbox({checked: v, meta: {name: name}})),
                  )
                }
              | _ => Error(RequirementNotFulfuilled)
              }
            })
            ->arrayTraverseResult(x => Ok(x))
            ->Result.getExn,
          }),
        }
        open RescriptStruct

        let _ =
          res->S.serializeToJsonStringWith(Form.Data.Codec.form, ~space=2)->Result.map(Console.log)
      }}>
      {f.groups
      ->Array.mapWithIndex((g, i) => interpretGroup({key: i->Int.toString, value: g}))
      ->Array.concat([<button type_="submit"> {"Submit"->React.string} </button>])
      ->React.array}
    </form>
}
