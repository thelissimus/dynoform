@@uncurried

open Form.Blueprint

module Interpreter = Adapter.ForReact

module MyForm = {
  let form = {
    name: "myform",
    description: "???",
    groups: [
      {
        name: "mygroup",
        order: 1,
        description: "???",
        elements: [
          SelectSingle({
            placeholder: "Interests",
            meta: {
              name: "interests",
              label: "Interests",
              description: "???",
              mustConfirm: false,
              required: true,
            },
            options: [{value: "1", label: "Eins"}, {value: "2", label: "Zwei"}],
          }),
          Text({
            placeholder: "Username",
            meta: {
              name: "name",
              label: "Username",
              description: "???",
              mustConfirm: false,
              required: false,
            },
          }),
          Checkbox({
            meta: {
              name: "agreed",
              label: "Agree to terms of service",
              description: "???",
              mustConfirm: false,
              required: false,
            },
          }),
        ],
      },
    ],
  }

  @genType @react.component
  let make = () => {
    // open RescriptStruct
    form->Interpreter.interpret
  }
}
