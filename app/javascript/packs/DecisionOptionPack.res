switch ReactDOM.querySelector("#decision-option-container") {
  | Some(root) => ReactDOM.render(<div> <DecisionOption /> </div>, root)
  | None => () // do nothing
}
