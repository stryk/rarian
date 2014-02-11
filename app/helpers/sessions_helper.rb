module SessionsHelper



	def current_user?(user)
		user == current_user
	end

  	def signed_in_user
		unless user_signed_in?
			redirect_to new_user_session_path, notice: "Please sign in." 
		end
 	end

	def redirect_back_or(default)
		redirect_to(session[:return_address] || default)
		session.delete(:return_address)
	end

	def get_saved_location		
		if session[:return_address].present?
			path = session[:return_address]
			session.delete(:return_address)
			return path
		else
			return false
		end
	end

	def save_location(path = nil)
		if path == nil
			session[:return_address] = request.fullpath
		else
			session[:return_address] = path
		end
	end
end