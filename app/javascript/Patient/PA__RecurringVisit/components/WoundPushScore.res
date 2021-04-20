let s = React.string
@react.component
let make = () => {
  let (show, setShow) = React.useState(_ => false)

  <div className="mt-10 field font-bold font-xs text-yellow-800">
    <button
      onClick={evt => {
        evt->ReactEvent.Mouse.preventDefault
        setShow(_ => true)
      }}>
      {s("Push Score ?")}
    </button>
    <PushScoreModal show setShow />
  </div>
}
