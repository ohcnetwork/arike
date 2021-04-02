let s = React.string

module SelectedPatient = {
  @react.component
  let make = (~name, ~ward_number) => {
    <li className="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200">
      <div className="w-full flex items-center justify-between p-6 space-x-6">
        <div className="flex-1 truncate">
          <div className="flex items-center space-x-3">
            <h3 className="text-gray-900 text-sm font-medium truncate"> {s(name)} </h3>
            <span
              className="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-xs font-medium bg-green-100 rounded-full">
              {s(`ward ${ward_number}`)}
            </span>
          </div>
        </div>
        <i className="fas fa-times" />
      </div>
    </li>
  }
}

@react.component
let make = () => {
  <div className="bg-gray-100 py-8 my-4">
    <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <ul className="grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <SelectedPatient name="Patient1" ward_number="1" />
        <SelectedPatient name="Patient1" ward_number="2" />
        <SelectedPatient name="Patient1" ward_number="2" />
        <SelectedPatient name="Patient1" ward_number="1" />
      </ul>
    </div>
  </div>
}
