let s = React.string

module Link = LayoutSidebar__Link

let header = () => {
  <a href="/" className="font-bold text-3xl md:text-5xl text-gray-700"> {s("Arike")} </a>
}

let selectedNavButtonClasses = bool => {
  let default = "group flex items-center px-2 py-2 text-sm font-medium rounded-md "

  default ++ (
    bool ? "bg-gray-100 text-gray-500" : "text-gray-600 hover:bg-gray-50 hover:text-gray-900 "
  )
}

let showLinks = links => {
  Js.Array.mapi((link, index) => {
    <a
      href={Link.link(link)}
      key={string_of_int(index)}
      className={selectedNavButtonClasses(Link.selected(link))}>
      <Faicon className={"fas fa-" ++ Link.icon(link) ++ " text-gray-500 mr-4 font-semibold"} />
      {s(Link.title(link))}
    </a>
  }, links)->React.array
}

let userDetails = currentUserName => {
  <div className="flex-shrink-0 flex border-t border-gray-200 p-4">
    <form action="/users/sign_out" className="flex-shrink-0 group block" method="POST">
      <input type_="hidden" value="delete" name="_method" />
      <input type_="hidden" value={AuthenticityToken.fromHead()} name="authenticity_token" />
      <div className="flex items-center">
        <div>
          <Avatar name={currentUserName} className="inline-block h-10 w-10 rounded-full" />
        </div>
        <div className="ml-3">
          <p className="text-base font-medium text-gray-700 group-hover:text-gray-900">
            {s(currentUserName)}
          </p>
          <button className="text-sm font-medium text-gray-500 group-hover:text-gray-700">
            {s("Logout")}
          </button>
        </div>
      </div>
    </form>
  </div>
}

let mobileMenu = (setShowMenu, links, currentUserName) => {
  <div className="fixed inset-0 flex z-40 md:hidden" role="dialog" ariaModal={true}>
    <div className="fixed inset-0 bg-gray-600 bg-opacity-75" ariaHidden={true} />
    <div className="relative flex-1 flex flex-col max-w-xs w-full bg-white">
      <div className="absolute top-0 right-0 -mr-12 pt-2">
        <button
          onClick={_ => setShowMenu(_ => false)}
          className="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
          <span className="sr-only"> {s("Close sidebar")} </span>
          <svg
            className="h-6 w-6 text-white"
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            ariaHidden={true}>
            <path
              strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M6 18L18 6M6 6l12 12"
            />
          </svg>
        </button>
      </div>
      <div className="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
        <div className="flex-shrink-0 flex items-center px-4"> {header()} </div>
        <nav className="mt-5 px-2 space-y-1"> {showLinks(links)} </nav>
      </div>
      {userDetails(currentUserName)}
    </div>
    <div className="flex-shrink-0 w-14" />
  </div>
}

let desktopMenu = (links, currentUserName) => {
  <div className="hidden md:flex md:flex-shrink-0 h-full">
    <div className="flex flex-col w-64">
      <div className="flex flex-col h-0 flex-1 border-r border-gray-200 bg-white">
        <div className="flex-1 flex flex-col pt-5 pb-4 overflow-y-auto">
          <div className="flex items-center flex-shrink-0 px-4"> {header()} </div>
          <nav className="mt-5 flex-1 px-2 bg-white space-y-1"> {showLinks(links)} </nav>
        </div>
        {userDetails(currentUserName)}
      </div>
    </div>
  </div>
}

@react.component
let make = (~links, ~currentUserName) => {
  let (showMenu, setShowMenu) = React.useState(_ => false)
  <>
    {showMenu ? mobileMenu(setShowMenu, links, currentUserName) : React.null}
    {desktopMenu(links, currentUserName)}
    <div className="flex flex-col w-0 flex-1 overflow-hidden">
      <div
        className="md:hidden pl-1 pt-1 sm:pl-3 sm:pt-3 absolute z-10 flex bg-white border-b w-full items-center">
        <button
          onClick={_ => setShowMenu(_ => !showMenu)}
          className="-ml-0.5 -mt-0.5 h-12 w-12 inline-flex items-center justify-center rounded-md text-gray-500 hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500">
          <span className="sr-only"> {s("Open sidebar")} </span>
          <i className="fas fa-bars text-2xl text-gray-700" />
        </button>
        {header()}
      </div>
    </div>
  </>
}
