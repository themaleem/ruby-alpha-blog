module ApplicationHelper
    def gravatar_for(user)
        email_address = user.email.downcase
        hash=Digest::MD5.hexdigest(email_address)
        image_src="https://www.gravatar.com/avatar/#{hash}?s=200"
        image_tag(image_src, alt:user.username, class:"rounded mx-auto d-block mb-5")
    end

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end
end
