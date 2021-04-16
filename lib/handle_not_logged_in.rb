class HandleNotLoggedIn < Devise::FailureApp
  def route(_scope)
    :root_path
  end
end
