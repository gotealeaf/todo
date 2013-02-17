def set_current_user
  john = Fabricate(:user)
  session[:user_id] = john.id
end
