module ApplicationHelper
  def user_photo(user, options = { size: 64, class: 'mr-3' })
    photo_id = Digest::MD5::hexdigest(user.email.downcase)
    photo_size = options[:size]
    image_class = options[:class]
    photo_url = "https://secure.gravatar.com/avatar/#{photo_id}?s=#{photo_size}"
    image_tag(photo_url, alt: 'User photo', class: image_class)
  end

  def follower_count(user)
    user.followers.size
  end

  def following_count(user)
    user.followeds.size
  end

  def user_subtext(user)
    if current_page?(progress_updates_path)
      (shared_user = user.shared_following(current_user)) ? "Followed by #{shared_user.full_name}" : ''
    else
      "@#{user.username}"
    end
  end

  def follow_or_unfollow_btn(user)
    return if current_page?(progress_updates_path) || user == current_user

    following = Following.find_by(followed: user, follower: current_user)
    if following
      # button_to('Unfollow!', user_following_path(following, user), method: :delete)
      button_to(user_following_path(following, user), method: :delete) { icon('fas', 'minus-circle') }
    else
      # button_to('Follow!', user_followings_path(user))
      button_to(user_followings_path(user)) { icon('fas', 'plus-circle') }
    end
  end
end
