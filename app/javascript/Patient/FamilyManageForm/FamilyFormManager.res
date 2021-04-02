type state = {
  relations: array<string>,
  educations: array<string>,
  occupations: array<string>,
  members: array<FamilyMemberForm.FamilyMember.t>,
}
@scope("JSON") @val
external parseJson: string => state = "parse"

let getData = dataId => {
  let elem =
    Domutils.doc->Domutils.getElementById(dataId)->Belt.Option.getWithDefault(Js.Obj.empty())

  elem["innerText"]->Domutils.replaceAll("&quot;", "\"")->parseJson
}
let s = React.string

open Belt

let count = ref(1)

type action =
  | AddFamilyMember
  | DeleteFamilyMember(FamilyMemberForm.FamilyMember.t)

let reducer = (state, action) =>
  switch action {
  | AddFamilyMember => {
      ...state,
      members: Belt.Array.concat(
        state.members,
        [FamilyMemberForm.FamilyMember.make(~id=Belt.Int.toString(count.contents))],
      ),
    }
  | DeleteFamilyMember(member) => {
      ...state,
      members: Js.Array.filter(m => m != member, state.members),
    }
  }



@react.component
let make = (~dataId) => {
  let initialState = getData(dataId)
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let new_props = FamilyMemberForm.FamilyMember.make(~id="0")
  let len = Js.Array.length(initialState.members)

  if(len > 0)
  {
    count := count.contents + len - 1;
  }
  else
  {
    count := count.contents
  }



  <div className="max-w-3xl mx-auto mt-8 relative">
    {Js.Array.length(state.members) > 0 ? (state.members
    ->Belt.Array.mapWithIndex((i, props) => {
      <FamilyMemberForm
        props
        key={i->Belt.Int.toString}
        onClick={_mouseEvt => DeleteFamilyMember(props)->dispatch}
        relations={state.relations}
        educations={state.educations}
        occupations={state.occupations}
      />})->React.array) : (
        <FamilyMemberForm
        props=new_props
        key={"0"}
        onClick={_mouseEvt => DeleteFamilyMember(new_props)->dispatch}
        relations={state.relations}
        educations={state.educations}
        occupations={state.occupations}
      />
      )
    }

    <button
      className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
      onClick={mouseEvt => {
        count := count.contents + 1
        mouseEvt->ReactEvent.Mouse.preventDefault
        AddFamilyMember->dispatch
      }}>
      {s("Add Family Member")}
    </button>
    <div />
    {if count.contents > 0 {
      <button
        type_="submit"
        className="mt-4 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
        {s("Save")}
      </button>
    } else {
      React.null
    }}
  </div>
}
