module ApplicationHelper
  def user_photo(user, options = { size: 64, class: 'mr-3' })
    photo_id = Digest::MD5::hexdigest(user.email.downcase)
    photo_size = options[:size]
    image_class = options[:class]
    photo_url = "https://secure.gravatar.com/avatar/#{photo_id}?s=#{photo_size}"
    image_tag(photo_url, alt: 'User photo', class: image_class)
  end
end
