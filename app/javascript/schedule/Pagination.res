let s = React.string

@react.component
let make = (~pageNumber, ~setPageNumber, ~maxPages) => {
  <div
    className="flex-col sm:flex-row text-center bg-white px-4 py-3 flex items-center justify-between sm:px-6">
    <div className=" sm:block">
      <p className="text-sm text-gray-700">
        {s("Showing")}
        <span className="font-medium m-1"> {s(pageNumber->Belt.Int.toString)} </span>
        {s("of")}
        <span className="font-medium m-1"> {s(maxPages->Belt.Int.toString)} </span>
        {s("pages")}
      </p>
    </div>
    <div className="flex-1 flex justify-between sm:justify-end">
      <button
        onClick={_evt => setPageNumber(prev => prev == 1 ? 1 : prev - 1)}
        className="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 m-2">
        <i className="fas fa-long-arrow-alt-left m-2" /> {s("Previous")}
      </button>
      <button
        onClick={_evt => setPageNumber(prev => prev == maxPages ? prev : prev + 1)}
        className="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 m-2">
        {s("Next")} <i className="fas fa-long-arrow-alt-right m-2" />
      </button>
    </div>
  </div>
}
