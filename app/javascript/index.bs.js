// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as ReactDom from "react-dom";
import * as AutoComplete$Arike from "./AutoComplete/AutoComplete.bs.js";

function s(prim) {
  return prim;
}

function runReact(root, api, name, id, label, placeholder) {
  var root$1 = document.querySelector("#" + root);
  if (root$1 == null) {
    console.log("hunu");
  } else {
    ReactDom.render(React.createElement(AutoComplete$Arike.make, {
              id: id,
              api: api,
              name: name,
              label: label,
              placeholder: placeholder,
              value: ""
            }), root$1);
  }
  
}

export {
  s ,
  runReact ,
  
}
/* react Not a pure module */
