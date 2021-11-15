import { alert } from "@pnotify/core"
import "@pnotify/core/dist/PNotify.css"
import "@pnotify/core/dist/BrightTheme.css"

const notify = (title, text, type) => {
  const notification = alert({
    type: type,
    title: title,
    text: text,
    closer: false,
    sticker: false,
    mode: "light",
  })

  notification.refs.elem.addEventListener("click", () => {
    notification.close()
  })
}

export default notify
