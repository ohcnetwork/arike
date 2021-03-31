class ApplicationPresenter

  def initialize(view_context)
    @view = view_context
  end


  private

  attr_reader :view

  delegate(
    :current_user,
    to: :view
  )
end
