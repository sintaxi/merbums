module Merb
  module GlobalHelpers
    # helpers defined here available to all views.
    def can_edit?(post)
      post.user_id == current_user.id || is_admin?
    end
  end
end
