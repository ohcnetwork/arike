let s = React.string

let header = () => {
  <div className="font-bold text-3xl md:text-5xl text-gray-700"> {s("Arike")} </div>
}

let mobileMenu = setShowMenu => {
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
        <nav className="mt-5 px-2 space-y-1">
          /* Current: "bg-gray-100 text-gray-900", Default: "text-gray-600 hover:bg-gray-50 hover:text-gray-900" */
          <a
            href="#"
            className="bg-gray-100 text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md">
            /* Current: "text-gray-500", Default: "text-gray-400 group-hover:text-gray-500" */
            /* Heroicon name: outline/home */
            <svg
              className="text-gray-500 mr-4 h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              ariaHidden={true}>
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
              />
            </svg>
            {s("Dashboard")}
          </a>
          <a
            href="#"
            className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md">
            /* Heroicon name: outline/users */
            <svg
              className="text-gray-400 group-hover:text-gray-500 mr-4 h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              ariaHidden={true}>
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"
              />
            </svg>
            {s("Team")}
          </a>
          <a
            href="#"
            className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md">
            /* Heroicon name: outline/folder */
            <svg
              className="text-gray-400 group-hover:text-gray-500 mr-4 h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              ariaHidden={true}>
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z"
              />
            </svg>
            {s("Projects")}
          </a>
          <a
            href="#"
            className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md">
            /* Heroicon name: outline/calendar */
            <svg
              className="text-gray-400 group-hover:text-gray-500 mr-4 h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              ariaHidden={true}>
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
              />
            </svg>
            {s("Calendar")}
          </a>
          <a
            href="#"
            className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md">
            /* Heroicon name: outline/inbox */
            <svg
              className="text-gray-400 group-hover:text-gray-500 mr-4 h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              ariaHidden={true}>
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
              />
            </svg>
            {s("Documents")}
          </a>
          <a
            href="#"
            className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-base font-medium rounded-md">
            /* Heroicon name: outline/chart-bar */
            <svg
              className="text-gray-400 group-hover:text-gray-500 mr-4 h-6 w-6"
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              ariaHidden={true}>
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth="2"
                d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
              />
            </svg>
            {s("Reports")}
          </a>
        </nav>
      </div>
      <div className="flex-shrink-0 flex border-t border-gray-200 p-4">
        <a href="#" className="flex-shrink-0 group block">
          <div className="flex items-center">
            <div> <Avatar name="Tom Cook" className="inline-block h-10 w-10 rounded-full" /> </div>
            <div className="ml-3">
              <p className="text-base font-medium text-gray-700 group-hover:text-gray-900">
                {s("Tom Cook")}
              </p>
              <p className="text-sm font-medium text-gray-500 group-hover:text-gray-700">
                {s("View profile")}
              </p>
            </div>
          </div>
        </a>
      </div>
    </div>
    <div className="flex-shrink-0 w-14" />
  </div>
}

let desktopMenu = () => {
  <div className="hidden md:flex md:flex-shrink-0 h-full">
    <div className="flex flex-col w-64">
      /* Sidebar component, swap this element with another sidebar if you like */
      <div className="flex flex-col h-0 flex-1 border-r border-gray-200 bg-white">
        <div className="flex-1 flex flex-col pt-5 pb-4 overflow-y-auto">
          <div className="flex items-center flex-shrink-0 px-4"> {header()} </div>
          <nav className="mt-5 flex-1 px-2 bg-white space-y-1">
            /* Current: "bg-gray-100 text-gray-900", Default: "text-gray-600 hover:bg-gray-50 hover:text-gray-900" */
            <a
              href="#"
              className="bg-gray-100 text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
              /* Current: "text-gray-500", Default: "text-gray-400 group-hover:text-gray-500" */
              /* Heroicon name: outline/home */
              <svg
                className="text-gray-500 mr-3 h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                ariaHidden={true}>
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"
                />
              </svg>
              {s("Dashboard")}
            </a>
            <a
              href="#"
              className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
              /* Heroicon name: outline/users */
              <svg
                className="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                ariaHidden={true}>
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z"
                />
              </svg>
              {s("Team")}
            </a>
            <a
              href="#"
              className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
              /* Heroicon name: outline/folder */
              <svg
                className="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                ariaHidden={true}>
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M3 7v10a2 2 0 002 2h14a2 2 0 002-2V9a2 2 0 00-2-2h-6l-2-2H5a2 2 0 00-2 2z"
                />
              </svg>
              {s("Projects")}
            </a>
            <a
              href="#"
              className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
              /* Heroicon name: outline/calendar */
              <svg
                className="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                ariaHidden={true}>
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                />
              </svg>
              {s("Calendar")}
            </a>
            <a
              href="#"
              className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
              /* Heroicon name: outline/inbox */
              <svg
                className="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                ariaHidden={true}>
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
                />
              </svg>
              {s("Documents")}
            </a>
            <a
              href="#"
              className="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
              /* Heroicon name: outline/chart-bar */
              <svg
                className="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
                ariaHidden={true}>
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth="2"
                  d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"
                />
              </svg>
              {s("Reports")}
            </a>
          </nav>
        </div>
        <div className="flex-shrink-0 flex border-t border-gray-200 p-4">
          <a href="#" className="flex-shrink-0 w-full group block">
            <div className="flex items-center">
              <div>
                <div>
                  <Avatar name="Tom Cook" className="inline-block h-10 w-10 rounded-full" />
                </div>
              </div>
              <div className="ml-3">
                <p className="text-sm font-medium text-gray-700 group-hover:text-gray-900">
                  {s("Tom Cook")}
                </p>
                <p className="text-xs font-medium text-gray-500 group-hover:text-gray-700">
                  {s("View profile")}
                </p>
              </div>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
}

@react.component
let make = () => {
  let (showMenu, setShowMenu) = React.useState(_ => false)
  <>
    {showMenu ? mobileMenu(setShowMenu) : React.null}
    {desktopMenu()}
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
