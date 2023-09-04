open RescriptStruct
open Form

let arrayToNonEmptyArray = struct => struct->S.transform(~parser=array =>
    switch array->NonEmptyArray.fromArray {
    | Some(ne) => ne
    | None => S.fail("supplied array is empty")
    }
  , ~serializer=NonEmptyArray.toArray, ())

let selectOptionCodec = S.object(o => {
  value: o->S.field("value", S.string()),
  label: o->S.field("label", S.string()),
})->S.Object.strict

let elementMetaCodec = S.object(o => {
  status: o->S.field(
    "status",
    S.union([
      S.literalVariant(String("active"), Active),
      S.literalVariant(String("inactive"), Inactive),
    ]),
  ),
  name: o->S.field("name", S.string()),
  title: o->S.field("title", S.string()),
  description: o->S.field("description", S.string()),
  mustConfirm: o->S.field("mustConfirm", S.bool()),
})

let element = S.union([
  S.object(o => {
    o->S.field("kind", S.literal(String("SelectSingle")))->ignore
    SelectSingle({
      selected: o->S.field("selected", S.option(S.string())),
      placeholder: o->S.field("placeholder", S.string()),
      options: o->S.field("options", S.array(selectOptionCodec)),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("SelectSingleRequired")))->ignore
    SelectSingleRequired({
      selected: o->S.field("selected", S.string()),
      placeholder: o->S.field("placeholder", S.string()),
      options: o->S.field("options", S.array(selectOptionCodec)),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("SelectMultiple")))->ignore
    SelectMultiple({
      selected: o->S.field("selected", S.array(S.string())),
      placeholder: o->S.field("placeholder", S.string()),
      options: o->S.field("options", S.array(selectOptionCodec)),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("SelectMultipleRequired")))->ignore
    SelectMultipleRequired({
      selected: o->S.field("selected", S.array(S.string())->arrayToNonEmptyArray),
      placeholder: o->S.field("placeholder", S.string()),
      options: o->S.field("options", S.array(selectOptionCodec)),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("Checkbox")))->ignore
    Checkbox({
      checked: o->S.field("checked", S.bool()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("Text")))->ignore
    Text({
      content: o->S.field("content", S.option(S.string())),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("TextRequired")))->ignore
    TextRequired({
      content: o->S.field("content", S.string()),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("Textarea")))->ignore
    Textarea({
      content: o->S.field("content", S.option(S.string())),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("TextareaRequired")))->ignore
    TextareaRequired({
      content: o->S.field("content", S.string()),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("Number")))->ignore
    Number({
      number: o->S.field("number", S.option(S.float())),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("NumberRequired")))->ignore
    NumberRequired({
      number: o->S.field("number", S.float()),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("Date")))->ignore
    Date({
      date: o->S.field("date", S.option(S.string()->S.String.datetime())),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  S.object(o => {
    o->S.field("kind", S.literal(String("DateRequired")))->ignore
    DateRequired({
      date: o->S.field("date", S.string()->S.String.datetime()),
      placeholder: o->S.field("placeholder", S.string()),
      meta: o->S.field("meta", elementMetaCodec),
    })
  }),
  // TODO: Photo, File
])
