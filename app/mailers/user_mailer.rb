class UserMailer < ApplicationMailer

    def account_activation(user)
        @user = user
        mail(to: @user.email, subject: "Activate your account - Members Only!")
    end

    def reset_password(user)
        @user = user
        mail(to: @user.email, subject: "Reset your password")
    end
end
