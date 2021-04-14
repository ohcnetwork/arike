module Layouts
  class SidebarPresenter < ::ApplicationPresenter
    def props
      {
        links: links,
        current_user_name: current_user.full_name
      }
    end

    def links
      presenter = ::Dashboard::IndexPresenter.new(view)
      presenter.links.map do |p|
        {
          title: p[:title],
          link: p[:link],
          selected: view.current_page?(p[:link]),
          icon: p[:icon],
        }
      end
    end
  end
end
