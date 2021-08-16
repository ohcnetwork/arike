let s = React.string

open PatientTreatment__Types

@react.component
let make = (~treatments) => {
  let treatments =
    treatments->Js.Array2.filter(treatment => treatment->Treatment.stopped_at != None)

  let deletedDates =
    treatments->Belt.Array.map(treatment =>
      treatment->Treatment.stopped_at->Belt.Option.getUnsafe->Js.Date.toDateString
    )

  let deletedDates = deletedDates->Js.Array2.filteri((date, index) => {
    deletedDates->Js.Array2.indexOf(date) == index
  })

  let treatmentHistories = deletedDates->Belt.Array.map(deletedDate => {
    TreatmentHistory.make(
      ~date=deletedDate->Js.Date.fromString,
      ~treatments=treatments->Js.Array2.filter(tr =>
        tr.stopped_at == Some(deletedDate->Js.Date.fromString)
      ),
    )
  })

  let treatmentHistories = treatmentHistories->Belt.Array.map(treatmentHistory => {
    let uid = treatmentHistory->TreatmentHistory.date->Js.Date.valueOf->Belt.Float.toString

    <div key=uid>
      <details>
        <summary className="font-bold mb-4 p-8 bg-gray-300 rounded-lg">
          {s(treatmentHistory->TreatmentHistory.date->Js.Date.toDateString)}
        </summary>
        <div className="flex flex-col">
          <div className="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div className="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
              <div className="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Treatment Name")}
                      </th>
                      <th
                        scope="col"
                        className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        {s("Category")}
                      </th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {treatmentHistory
                    ->TreatmentHistory.treatments
                    ->Belt.Array.map(treatment => {
                      <tr key={`${uid}-${treatment->Treatment.id}`}>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="flex items-center">
                            <div className="ml-4">
                              <div className="text-sm font-medium text-gray-900">
                                {s(treatment->Treatment.name)}
                              </div>
                            </div>
                          </div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="text-sm text-gray-900">
                            {s(treatment->Treatment.category)}
                          </div>
                          <div className="text-sm text-gray-500">
                            {s(treatment->Treatment.created_at->Js.Date.toDateString)}
                          </div>
                        </td>
                      </tr>
                    })
                    ->React.array}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </details>
    </div>
  })

  <div> {treatmentHistories->React.array} </div>
}
