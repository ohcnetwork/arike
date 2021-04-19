let s = React.string
@react.component
let make = () => {
  let (show, setShow) = React.useState(_ => false)

  <div className="mt-10 field">
    <button
      onClick={evt => {
        evt->ReactEvent.Mouse.preventDefault
        setShow(_ => true)
      }}>
      {s("Open Modal")}
    </button>
    <Modal show setShow />
  </div>
}
