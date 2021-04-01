let s = React.string

type options = Assign | Revisit | Expired | NotChoosen

module DisplayOptions = {
    @react.component
    let make = (~onSelect) => {
        <div className="flex flex-col items-center">
            <button onClick={_ => onSelect(_ => Assign)} className="my-10 group relative w-5/12 flex justify-center py-3 px-4 border border-transparent text-lg font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                {s("Assign To")}
            </button>
            <button onClick={_ => onSelect(_ => Revisit)} className="my-10 group relative w-5/12 flex justify-center py-3 px-4 border border-transparent text-lg font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                {s("Schedule Revisit")}
            </button>
            <button onClick={_ => onSelect(_ => Expired)} className="my-10 group relative w-5/12 flex justify-center py-3 px-4 border border-transparent text-lg font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
                {s("Patient Expired")}
            </button>
        </div>
    }
}

@react.component
let make = () => {
    let (optionChose, setOptionChose) = React.useState(() => NotChoosen)

    <>
        <div className="pb-5 border-b border-gray-200 sm:flex sm:items-center sm:justify-between">
          <h1 className="text-3xl font-bold leading-tight text-gray-900">
            {s("Decision Option")}
          </h1>
        </div>

        {
            switch optionChose {
            | Assign => <>{s("assign")}</>
            | Revisit => <>{s("revisit")}</>
            | Expired => <>{s("expired")}</>
            | NotChoosen => <DisplayOptions onSelect={e => e->setOptionChose} />
            }
        }
    </>
}
