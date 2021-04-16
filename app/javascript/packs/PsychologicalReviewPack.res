switch ReactDOM.querySelector("#psychological-review-form") {
| Some(root) =>
  ReactDOM.render(<PsychologicalReview__Form />, root)
| None => ()
}
