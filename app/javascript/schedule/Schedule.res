let s = React.string

module Schedule = {
  @react.component
  let make = (~visits) => {
    Js.log(visits)
    <div> <Patient /> </div>
  }
}

let run = visits => {
  switch ReactDOM.querySelector("#schedule") {
  | Some(root) => ReactDOM.render(<div> <Schedule visits /> </div>, root)
  | None => ()
  }
}
