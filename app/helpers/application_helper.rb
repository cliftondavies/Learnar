module ApplicationHelper
  def user_photo(user, options = { size: 45, class: 'mr-2' })
    photo_id = Digest::MD5.hexdigest(user.email.downcase)
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

  def shared_following(user_one, user_two)
    user_one.followeds.where(id: user_two.follower_ids).take
  end

  def user_subtext(user)
    if current_page?(progress_updates_path)
      if (shared_user = shared_following(current_user, user))
        "Followed by #{link_to shared_user.full_name, user_path(shared_user), class: 'blue-link'}".html_safe
      else
        ''
      end
    else
      link_to "@#{user.username}", user_path(user), class: 'text-decoration-none'
    end
  end

  def follow_unfollow(user)
    return if current_page?(progress_updates_path) || user == current_user

    following = Following.find_by(followed: user, follower: current_user)
    if following
      button_to(user_following_path(user, following), method: :delete,
                                                      class: 'rounded-circle px-2 py-1 mr-2') do
        icon('fas', 'minus-circle')
      end
    else
      button_to(user_followings_path(user), class: 'rounded-circle px-2 py-1 mr-2') do
        icon('fas', 'plus-circle')
      end
    end
  end

  def home_link
    return if current_page?(root_path)

    link_to(root_path, class: 'home-link position-absolute border border-white py-1 px-1 rounded') do
      icon('fas', 'brain', class: 'text-dark fa-2x')
    end
  end
end
