module UsersHelper
	def hide_email(user)
		if user_signed_in? && current_user == user
			user.email
		else
			"hide@ma.il"
		end
	end
end
