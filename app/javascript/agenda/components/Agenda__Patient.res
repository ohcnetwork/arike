@val external window: {..} = "window"

type patient = Agenda__Types.patient

let s = React.string

@react.component
let make = (~patient: patient) => {

    let unschedule = _ => {
        let payload = Js.Dict.empty()
        Js.Dict.set(payload, "patient", Js.Json.string(patient.id))

        Fetch.fetchWithInit(
        "/schedule",
        Fetch.RequestInit.make(
            ~method_=Delete,
            ~body=Fetch.BodyInit.make(Js.Json.stringify(Js.Json.object_(payload))),
            ~headers=Fetch.HeadersInit.make({"Content-Type": "application/json"}),
            (),
        ),
        ) |> Js.Promise.then_(_ => window["location"]["reload"](true)->ignore |> Js.Promise.resolve)
    }->ignore
        


    <div className="col-span-1 bg-white rounded-lg border border-gray-100 shadow divide-y divide-gray-200">
        <div className="w-full flex items-center justify-between p-6 space-x-6">
            <div className="flex-1 truncate">
                <div className="flex items-center space-x-3">
                    <h3 
                        onClick={event => {
                            event->ReactEvent.Mouse.stopPropagation
                            window["location"]["href"] = `patients/${patient.id}`
                        }}
                        className="text-gray-600 text-md font-bold cursor-pointer">
                        {s(patient.name)}
                    </h3>
                    <span className="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-xs font-medium bg-green-100 rounded-full">
                        {s(`ward ${patient.ward->Belt.Int.toString}`)}
                    </span>
                </div>
            </div>
        </div>

        <div className="flex align-center justify-evenly">
            <button
                onClick={unschedule}
                className="items-center my-2 p-1 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-red-500 hover:bg-red-600 focus:outline-none">
                {s("Unschedule")}
            </button>

            <button
                onClick={event => {
                    event->ReactEvent.Mouse.stopPropagation
                    window["location"]["href"] = `patients/${patient.id}/visit_details/new`
                }}
                className="items-center my-2 p-1 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-green-500 hover:bg-green-600 focus:outline-none">
                {s("Visit Patient")}
            </button>
        </div>
    </div>
}