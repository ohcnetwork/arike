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
let make = () => {
  let (scores, setScores) = React.useState(_ => {
    scores: {dimension: 0, exudate: 0, tissue: 0},
    pushScore: 0,
  })

  <div className="mt-10 sm:col-span-3 field">
    <div className="mb-5">
      <label
        className="block text-sm font-medium
        text-gray-700">
        {s("Length x Width (cm")} <sup> {s("2")} </sup> {s(")")}
      </label>
      <select
        className="mt-1 mb-5 max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
        onChange={e =>
          setScores(prevState => {
            pushScore: prevState.pushScore -
            prevState.scores.dimension +
            ReactEvent.Form.target(e)["value"]->Belt.Int.fromString->Belt.Option.getWithDefault(0),
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
        className="mt-1 mb-5 max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
        onChange={e =>
          setScores(prevState => {
            pushScore: prevState.pushScore -
            prevState.scores.exudate +
            ReactEvent.Form.target(e)["value"]->Belt.Int.fromString->Belt.Option.getWithDefault(0),
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
        className="mt-1 mb-5 max-w-lg block focus:ring-indigo-500 focus:border-indigo-500 w-full shadow-sm sm:max-w-xs sm:text-sm border-gray-300 rounded-md"
        onChange={e =>
          setScores(prevState => {
            pushScore: prevState.pushScore -
            prevState.scores.tissue +
            ReactEvent.Form.target(e)["value"]->Belt.Int.fromString->Belt.Option.getWithDefault(0),
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
    <div className="lg:w-80 sm:w-full"> <PushScoreBar value={scores.pushScore} /> </div>
  </div>
}
