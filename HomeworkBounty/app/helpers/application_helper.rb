module ApplicationHelper
	def avatar_url(user)
		if(!user.is_a?(User))
			user = User.find(user)
		end
		default_url = "#{root_url}'public/images/default_avatar.png'}"
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=80"
	end
	def large_avatar_url(user)
		default_url = "#{root_url}'public/images/default_avatar.png'}"
		gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
		"http://gravatar.com/avatar/#{gravatar_id}.png?s=215"
	end
end
