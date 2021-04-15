type state =
  | GeneralHealthInfoForm
  | PsychologicalReviewForm
  | PhysicalSymptomsForm
  | PhysicalExaminationForm
let forms = [
  GeneralHealthInfoForm,
  PsychologicalReviewForm,
  PhysicalSymptomsForm,
  PhysicalExaminationForm,
]
let formToS = (form: state) => {
  switch form {
  | GeneralHealthInfoForm => "General Health Information"
  | PsychologicalReviewForm => "Psychological Review"
  | PhysicalSymptomsForm => "Physical Symptoms"
  | PhysicalExaminationForm => "Physical Examination"
  }
}
let formToForm = (~form: state, ~name, ~role) => {
  switch form {
  | GeneralHealthInfoForm => <GeneralHealthInfo__Form />
  | PsychologicalReviewForm => <PsychologicalReview__Form />
  | PhysicalSymptomsForm => <PhysicalSymptoms__Form />
  | PhysicalExaminationForm => <PhysicalExamination__Form name role />
  }
}
type action =
  | Next
  | Back
  | Goto(state)

let reducer = (state, action) =>
  switch action {
  | Next => {
      let i = forms->Js.Array2.findIndex(e => e == state)
      if i >= 0 && i < Js.Array.length(forms) - 1 {
        forms[i + 1]
      } else {
        state
      }
    }

  | Back => {
      let i = forms->Js.Array2.findIndex(e => e == state)
      if i > 0 {
        forms[i - 1]
      } else {
        state
      }
    }
  | Goto(newState) => newState
  }
let initialState = GeneralHealthInfoForm
let s = React.string

/* Add State for capturing data */
@react.component
let make = (~name, ~role) => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div className="px-4 sm:px-6 lg:px-8 bg-white">
      <div className="max-w-7xl mx-auto">
        <div>
          <div className="sm:hidden">
            <label className="sr-only"> {s("Select a tab")} </label>
            <select
              id="tabs"
              name="tabs"
              className="block focus:ring-indigo-500 focus:border-indigo-500 border-gray-300 rounded-md">
              {forms
              ->Js.Array2.map(form =>
                <option selected={form == state}> {s(form->formToS)} </option>
              )
              ->React.array}
            </select>
          </div>
          <div className="hidden sm:block">
            <div className="border-b border-gray-200">
              <nav className="-mb-px flex space-x-8">
                {forms
                ->Js.Array2.map(form => {
                  if form == state {
                    <a
                      onClick={_ => Goto(form)->dispatch}
                      className="cursor-pointer border-indigo-500 text-indigo-600 group inline-flex items-center py-4 px-1 border-b-2 font-medium text-sm">
                      <span> {s(form->formToS)} </span>
                    </a>
                  } else {
                    <a
                      onClick={_ => Goto(form)->dispatch}
                      className="cursor-pointer border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 group inline-flex items-center py-4 px-1 border-b-2 font-medium text-sm">
                      <span> {s(form->formToS)} </span>
                    </a>
                  }
                })
                ->React.array}
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div className="max-w-3xl mx-auto py-5">
      <form className="space-y-8" action="/visit_details" id="patientvitals-form" method="post">
        <div className="space-y-8 sm:space-y-5">
          <div>
            <div>
              <h3 className="text-lg leading-6 font-medium text-gray-900">
                {s("Visit Details")}
              </h3>
            </div>
            <div className="mt-6 sm:mt-5 space-y-6 sm:space-y-5 gap-y-6 gap-x-4">
              {forms
              ->Js.Array2.map(form => {
                if state == form {
                  formToForm(~form, ~name, ~role)
                } else {
                  <div className="hidden"> {formToForm(~form, ~name, ~role)} </div>
                }
              })
              ->React.array}
            </div>
          </div>
        </div>
        <div className="pt-5">
          <div className="flex justify-center">
            <button
              type_="button"
              onClick={mouseEvt => {
                mouseEvt->ReactEvent.Mouse.preventDefault
                Back->dispatch
              }}
              className="bg-white py-2 px-16 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              {s("Back")}
            </button>
            <button
              type_="submit"
              onClick={mouseEvt => {
                if state != forms[Js.Array.length(forms) - 1] {
                  mouseEvt->ReactEvent.Mouse.preventDefault
                }
                Next->dispatch
              }}
              className="ml-3 inline-flex justify-center py-2 px-16 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              {s(
                if state != forms[Js.Array.length(forms) - 1] {
                  "Next"
                } else {
                  "Submit"
                },
              )}
            </button>
          </div>
        </div>
      </form>
    </div>
  </div>
}
