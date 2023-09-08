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
          ->Belt.Array.mapWithIndexU((i, {label, value}) =>
            <option label value key={i->Int.toString} />
          )
          ->Belt.Array.concat([
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
          ->Belt.Array.mapWithIndexU((i, {label, value}) =>
            <option label value key={i->Int.toString} />
          )
          ->Belt.Array.concat([
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
      ->NonEmptyArray.toArray
      ->Belt.Array.mapWithIndexU((i, e) => interpretElement({key: i->Int.toString, value: e}))
      ->React.array}
    </section>

  let interpret = f =>
    <form
      onSubmit={e => {
        ReactEvent.Form.preventDefault(e)
        Console.log(e)
      }}>
      {f.groups
      ->NonEmptyArray.toArray
      ->Belt.Array.mapWithIndexU((i, g) => interpretGroup({key: i->Int.toString, value: g}))
      ->Belt.Array.concat([<button type_="submit"> {"Submit"->React.string} </button>])
      ->React.array}
    </form>
}
