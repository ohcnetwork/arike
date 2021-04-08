exception RootElementMissing(string)

type document
@send external getElementById: (document, string) => option<{..}> = "getElementById"
@val external doc: document = "document"
@send external focus: {..} => unit = "focus"
@send external createElement: (document, string) => Dom.element = "createElement"
// string.replaceAll(string, string)
@send external replaceAll: (string, string, string) => string = "replaceAll"
@val external window: {..} = "window"

// elem.focus
let focus = id =>
  switch doc->getElementById(id) {
  | Some(el) => el
  | None => raise(RootElementMissing(id))
  }
  ->focus
  ->ignore
