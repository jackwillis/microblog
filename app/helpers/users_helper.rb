module UsersHelper
  def profile_link(user)
    link_to "#{user.handle} (@#{user.username})", user_path(user)
  end
end
