let jssort = %raw(`
  function(array, property, asAscending) {
    return array.sort((a, b) => {
      let c = a[property];
      let d = b[property];
      return asAscending ? c - d : d - c;
    })
  }
`)

// let x = props.patients->Belt.Array.reduce([], (acc, patient) => {
//   let s0 = Belt.Set.String.fromArray(acc)
//   let s1 = Belt.Set.String.fromArray(patient.procedures)
//   let acc = Belt.Set.String.union(s0, s1)
//   acc->Belt.Set.String.toArray
// })

let jsunion = %raw(`
  function(array, property) {
    return array.reduce((acc, element) => [...new Set([...acc, ...element[property]])], []);
  }
`)
