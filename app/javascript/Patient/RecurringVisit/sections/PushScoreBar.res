let s = React.string

@react.component
let make = (~value: int) => {
  let changeProgressBar = value => {
    let width = value->Belt.Int.toFloat /. 17.0 *. 100.0
    j`$width%`
  }

  <div className="my-4 flex justify-center items-center">
    <div className="w-full h-4 bg-red-200 border-2 border-red-700 rounded-full">
      <div
        className="transition-all duration-1000 ease-out rounded-full h-full bg-red-700"
        style={ReactDOM.Style.make(~width=changeProgressBar(value), ())}
      />
    </div>
    <p className="text-white bg-red-500 p-2 rounded-full ml-4 shadow-lg">
      {s(`${value->Belt.Int.toString}.0`)}
    </p>
  </div>
}
