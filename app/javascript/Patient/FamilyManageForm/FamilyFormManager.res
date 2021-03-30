let s = React.string

open Belt

let count = ref(0)
type state = array<FamilyMemberForm.FamilyMember.t>

type action =
  | AddFamilyMember
  | DeleteFamilyMember(FamilyMemberForm.FamilyMember.t)

let reducer = (state, action) =>
  switch action {
  | AddFamilyMember =>
    Belt.Array.concat(state, [FamilyMemberForm.FamilyMember.make(~id=count.contents)])
  | DeleteFamilyMember(member) => Js.Array.filter(m => m != member, state)
  }

let initialState = []

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let submit = if count.contents > 0 {
    <button type_="submit" className="bg-blue-200 text-blue-800 rounded"> {s("Save")} </button>
  } else {
    React.null
  }
  <div className="max-w-3xl mx-auto mt-8 relative">
    {state
    ->Belt.Array.mapWithIndex((i, props) => {
      <FamilyMemberForm
        props key={i->Belt.Int.toString} onClick={_mouseEvt => DeleteFamilyMember(props)->dispatch}
      />
    })
    ->React.array}
    <button
      className="bg-blue-200 text-blue-800 rounded"
      onClick={mouseEvt => {
        count := count.contents + 1
        mouseEvt->ReactEvent.Mouse.preventDefault
        AddFamilyMember->dispatch
      }}>
      {s("Add Family Member")}
    </button>
    {submit}
  </div>
}
