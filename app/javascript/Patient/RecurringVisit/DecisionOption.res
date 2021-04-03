let s = React.string

type options = Assign | Revisit | Expired | NotChoosen

module DisplayOptions = {
  @react.component
  let make = (~onSelect) => {
    <div className="flex flex-col items-center">
      <button
        onClick={_ => onSelect(_ => Assign)}
        className="my-10 group relative w-5/12 flex justify-center py-3 px-4 border border-transparent text-lg font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
        {s("Assign To")}
      </button>
      <button
        onClick={_ => onSelect(_ => Revisit)}
        className="my-10 group relative w-5/12 flex justify-center py-3 px-4 border border-transparent text-lg font-medium rounded-md text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
        {s("Schedule Revisit")}
      </button>
      <button
        onClick={_ => onSelect(_ => Expired)}
        className="my-10 group relative w-5/12 flex justify-center py-3 px-4 border border-transparent text-lg font-medium rounded-md text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500">
        {s("Patient Expired")}
      </button>
    </div>
  }
}

module Decision_AssignTo = {
  @react.component
  let make = () => {
    <div className="w-full flex flex-col items-center justify-center py-12">
      <div className="flex items-center p-3">
        <input
          type_="checkbox"
          id="specialist"
          className="mr-2 focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
        />
        <label htmlFor="specialist"> {s("Assign to Specialist Nurse")} </label>
      </div>
      <div className="flex items-center p-3">
        <input
          type_="checkbox"
          id="physiotherapist"
          className="mr-2 focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
        />
        <label htmlFor="physiotherapist"> {s("Assign to Physiotherapist")} </label>
      </div>
      <div className="flex items-center p-3">
        <input
          type_="checkbox"
          id="accompany-doctor"
          className="mr-2 focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded"
        />
        <label htmlFor="accompany-doctor"> {s("Doctor should accompany")} </label>
      </div>
      <div className="flex items-center p-3">
        <button
          className="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          {s("Submit")}
        </button>
      </div>
    </div>
  }
}

module Decision_Revisit = {
  @react.component
  let make = () => {
    <div className="w-full flex flex-col items-center justify-center py-12">
      <div className="p-3 w-11/12 md:w-7/12">
          <label className="block text-sm font-medium
        text-gray-700" htmlFor="revisit-date">{s("Revisit Date")}</label>
          <div className="mt-1">
            <input className="shadow-sm focus:ring-indigo-500
          focus:border-indigo-500 block w-full sm:text-sm border-gray-300
          rounded-md" type_="date" id="revisit-date" />
          </div>
      </div>
      <div className="p-3">
        <button
          className="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          {s("Submit")}
        </button>
      </div>
    </div>
  }
}

module Decision_Expired = {
    @react.component
    let make = () => {
        <div className="w-full flex flex-col items-center justify-center py-12">
            <div className="p-3 w-11/12 md:w-7/12">
                <label className="block text-sm font-medium
                text-gray-700" htmlFor="expired-date">{s("Expired Date")}</label>
                <div className="mt-1">
                    <input className="shadow-sm focus:ring-indigo-500
                focus:border-indigo-500 block w-full sm:text-sm border-gray-300
                rounded-md" type_="date" id="expired-date" />
                </div>
            </div>
            <div className="p-3">
                <button
                className="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                {s("Submit")}
                </button>
            </div>
        </div>    
    }
} 

@react.component
let make = () => {
  let (optionChose, setOptionChose) = React.useState(() => NotChoosen)

    let handleBackButton = () => {
        setOptionChose(_ => NotChoosen);
    }

  <>
    <div className="pb-5 border-b border-gray-200 sm:flex sm:items-center">
      {
          switch optionChose {
            | NotChoosen => <></>
            | _ => <span onClick={_ => handleBackButton()}><i className="fa fa-arrow-left text-lg cursor-pointer mr-2"></i></span>
          }
      }
      <h1 className="text-3xl font-bold leading-tight text-gray-900 cursor-pointer focus:outline-none"> {s("Decision Option")} </h1>
    </div>
    {switch optionChose {
    | Assign => <Decision_AssignTo />
    | Revisit => <Decision_Revisit />
    | Expired => <Decision_Expired />
    | NotChoosen => <DisplayOptions onSelect={e => e->setOptionChose} />
    }}
  </>
}
