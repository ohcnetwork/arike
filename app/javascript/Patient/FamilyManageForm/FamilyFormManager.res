let s = React.string

open Belt

let count = ref(0)
type state = array<FamilyMemberForm.FamilyMember.t>

type action =
  | AddFamilyMember
  | DeleteFamilyMember(FamilyMemberForm.FamilyMember.t)

let reducer = (state, action) =>
  switch action {
  | AddFamilyMember => {
      count := count.contents + 1
      Belt.Array.concat(state, [FamilyMemberForm.FamilyMember.make(~id=count.contents)])
    }
  | DeleteFamilyMember(member) => Js.Array.filter(m => m != member, state)
  }

let initialState = []

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  <div className="max-w-3xl mx-auto mt-8 relative">
    {state
    ->Belt.Array.map(props => {
      <FamilyMemberForm props onClick={_mouseEvt => DeleteFamilyMember(props)->dispatch} />
    })
    ->React.array}
    <button
      className="bg-blue-200 text-blue-800 rounded"
      onClick={mouseEvt => {
        mouseEvt->ReactEvent.Mouse.preventDefault
        AddFamilyMember->dispatch
      }}>
      {s("Add Family Member")}
    </button>
  </div>
}
