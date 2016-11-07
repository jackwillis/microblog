module UserHelper
  def profile_link(user)
    link_to "#{user.handle} (@#{user.username})", root_path
  end
end
