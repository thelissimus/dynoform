open Form.Blueprint

module Interpreter = Adapter.ForReact

module MyForm = {
  @genType @react.component
  let make = () =>
    {
      name: "myform",
      description: "???",
      groups: NonEmptyArray.fromArrayUnsafe([
        {
          name: "mygroup",
          order: 1,
          description: "???",
          elements: NonEmptyArray.fromArrayUnsafe([
            Text({
              placeholder: "Username",
              meta: {
                name: "name",
                label: "Username",
                description: "???",
                mustConfirm: false,
                required: true,
              },
            }),
            Checkbox({
              meta: {
                name: "agreed",
                label: "Agree to terms of service",
                description: "???",
                mustConfirm: false,
                required: true,
              },
            }),
          ]),
        },
      ]),
    }->Interpreter.interpret
}
