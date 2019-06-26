module SessionsHelper

    
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        @current_user ||= User.find(session[:user_id])
    end

    def current_user?(user)
        user == current_user
    end


    def logged_in?
        !session[:user_id].nil?
    end

    def log_out
        session[:user_id] = nil
        @current_user = nil
    end

    def remember(user)
        user.remember
        cookies.signed.permanent[:remember_token] = user.remember_token
    end

    def forget(user)
        user.forget
        cookies[:remember_token] = nil
    end

end
