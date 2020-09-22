module ApplicationHelper
  def user_photo(user, options = { size: 45, class: 'mr-2' })
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
      # (shared_user = user.shared_following(current_user)) ? "Followed by #{shared_user.full_name}" : ''
      if (shared_user = user.shared_following(current_user))
        "Followed by #{link_to shared_user.full_name, user_path(user), class: 'blue-link'}"
      else
        ''
      end
    else
      # "@#{user.username}"
      link_to "@#{user.username}", user_path(user)
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

  def home_link
    return if current_page?(root_path)

    link_to(root_path, class: 'home-link position-absolute border border-white py-1 px-1 rounded') do
      icon('fas', 'brain', class: 'text-dark fa-2x')
    end
  end
end
