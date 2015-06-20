module UsersHelper
  def hide_email(user)
    if user_signed_in? && current_user == user
      user.email
    else
      #my-email@example.com -> m******l@example.com
      split_email = user.email.split("@")
      size_name_email = split_email[0].size
      email = split_email[0][0]
      (size_name_email - 2).times { |_| email += "*" }
      email += split_email[0][size_name_email - 1]
      email + "@" + split_email[1]
    end
  end
end
