exception RootElementMissing(string)
exception DataElementMissing(string)
exception RootAttributeMissing(string)

open Webapi.Dom

let focus = id =>
  (switch document |> Document.getElementById(id) {
  | Some(el) => el
  | None => raise(RootElementMissing(id))
  } |> Element.asHtmlElement)->Belt.Option.map(HtmlElement.focus) |> ignore

let parseJSONTag = (~id="react-root-data", ()) =>
  switch document |> Document.getElementById(id) {
  | Some(rootElement) => rootElement |> Element.innerHTML
  | None => raise(DataElementMissing(id))
  } |> Json.parseOrRaise

let parseJSONAttribute = (~id="react-root", ~attribute="data-json-props", ()) =>
  switch document |> Document.getElementById(id) {
  | Some(rootElement) =>
    switch rootElement |> Element.getAttribute(attribute) {
    | Some(props) => props
    | None => raise(RootAttributeMissing(attribute))
    }
  | None => raise(RootElementMissing(id))
  } |> Json.parseOrRaise
@send external replaceAll: (string, string, string) => string = "replaceAll"
