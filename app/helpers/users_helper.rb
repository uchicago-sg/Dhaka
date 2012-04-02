module UsersHelper
  def update_roles_link(user, role, link_text)
    return link_to( link_text, update_roles_user_path(user,:role=>role), :remote=>true, :class=>role)
  end
end