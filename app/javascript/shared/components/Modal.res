let s = React.string

type scores = {dimension: int, exudate: int, tissue: int}
type pushScore = int
type initialState = {scores: scores, pushScore: pushScore}

let dimensionArray = [
  (0, "None"),
  (1, "< 0.3"),
  (2, "0.3 - 0.6"),
  (3, "0.7 - 1.0"),
  (4, "1.1 - 2.0"),
  (5, "2.1 - 3.0"),
  (6, "3.1 - 4.0"),
  (7, "4.1 - 8.0"),
  (8, "8.1 - 12.0"),
  (9, "12.1 - 24.0"),
  (10, "> 24"),
]

let exudateArray = [(0, "None"), (1, "Light"), (2, "Moderate"), (3, "High")]

let tissueArray = [
  (0, "Closed"),
  (1, "Epithelial"),
  (2, "Granulation"),
  (3, "Slough"),
  (4, "Necrotic"),
]

let renderOptions = optionsArray => {
  optionsArray
  ->Belt.Array.map(((point, option)) =>
    <option value={point->Belt.Int.toString} key={point->Belt.Int.toString}> {s(option)} </option>
  )
  ->React.array
}

@react.component
let make = (~show, ~setShow) => {
  let (scores, setScores) = React.useState(_ => {
    scores: {dimension: 0, exudate: 0, tissue: 0},
    pushScore: 0,
  })
  let handleFormSubmit = _ => ()
  let autoFocus = true
  let required = true

  {
    show
      ? <>
          <div
            className="justify-center items-center flex overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none">
            <div className="relative my-6 mx-auto md:w-1/3">
              {/* content */ React.null}
              <div
                className="border-0 rounded-lg shadow-lg relative flex flex-col w-full bg-white outline-none focus:outline-none">
                {/* header */ React.null}
                <div
                  className="flex items-start justify-between p-5 border-b border-solid border-blueGray-200 rounded-t">
                  <h3 className="text-3xl font-semibold"> {s("Add To Dictionary")} </h3>
                  <button
                    className="p-1 ml-auto bg-transparent border-0 text-black float-right text-3xl leading-none font-semibold outline-none focus:outline-none"
                    onClick={_ => setShow(_ => false)}>
                    <span
                      className="bg-transparent text-black h-6 w-6 text-2xl block outline-none focus:outline-none">
                      <i className="fa fa-times" />
                    </span>
                  </button>
                </div>
                {/* body */ React.null}
                <form action="#" onSubmit={handleFormSubmit}>
                  <div className="mb-5 px-2">
                    <label
                      className="block text-sm font-medium
        text-gray-700">
                      {s("Length x Width (cm")} <sup> {s("2")} </sup> {s(")")}
                    </label>
                    <select
                      className="px-1 mt-1 mb-5 max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
                      onChange={e =>
                        setScores(prevState => {
                          pushScore: prevState.pushScore -
                          prevState.scores.dimension +
                          ReactEvent.Form.target(e)["value"]
                          ->Belt.Int.fromString
                          ->Belt.Option.getWithDefault(0),
                          scores: {
                            ...prevState.scores,
                            dimension: ReactEvent.Form.target(e)["value"]
                            ->Belt.Int.fromString
                            ->Belt.Option.getWithDefault(0),
                          },
                        })}>
                      {renderOptions(dimensionArray)}
                    </select>
                    <label
                      className="block text-sm font-medium
        text-gray-700">
                      {s("Exudate Amount")}
                    </label>
                    <select
                      className="px-1 mt-1 mb-5 max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
                      onChange={e =>
                        setScores(prevState => {
                          pushScore: prevState.pushScore -
                          prevState.scores.exudate +
                          ReactEvent.Form.target(e)["value"]
                          ->Belt.Int.fromString
                          ->Belt.Option.getWithDefault(0),
                          scores: {
                            ...prevState.scores,
                            exudate: ReactEvent.Form.target(e)["value"]
                            ->Belt.Int.fromString
                            ->Belt.Option.getWithDefault(0),
                          },
                        })}>
                      {renderOptions(exudateArray)}
                    </select>
                    <label
                      className="block text-sm font-medium
        text-gray-700">
                      {s("Tissue Type")}
                    </label>
                    <select
                      className="px-1 mt-1 mb-5 max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
                      onChange={e =>
                        setScores(prevState => {
                          pushScore: prevState.pushScore -
                          prevState.scores.tissue +
                          ReactEvent.Form.target(e)["value"]
                          ->Belt.Int.fromString
                          ->Belt.Option.getWithDefault(0),
                          scores: {
                            ...prevState.scores,
                            tissue: ReactEvent.Form.target(e)["value"]
                            ->Belt.Int.fromString
                            ->Belt.Option.getWithDefault(0),
                          },
                        })}>
                      {renderOptions(tissueArray)}
                    </select>
                  </div>
                  <div className="px-1 lg:w-80 sm:w-full">
                    <PushScoreBar value={scores.pushScore} />
                  </div>
                  {/* footer */ React.null}
                  <div
                    className="flex items-center justify-end p-6 border-t border-solid border-blueGray-200 rounded-b">
                    <button
                      className="text-red-500 background-transparent font-bold uppercase px-6 py-2 text-sm outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                      type_="button"
                      onClick={_ => setShow(_ => false)}>
                      {s("Cancel")}
                    </button>
                    <button
                      className="flex justify-between items-center bg-indigo-500 text-white active:bg-emerald-600 font-bold uppercase text-sm px-6 py-3 rounded shadow hover:shadow-lg outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                      type_="submit">
                      {s("Add")}
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <div className="opacity-25 fixed inset-0 z-40 bg-black" />
        </>
      : React.null
  }
}
