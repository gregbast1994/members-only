module UsersHelper
    def gravatar_for(user, size="50")
        digest = Digest::MD5.hexdigest(user.email)
        image_tag "https://www.gravatar.com/avatar/#{digest}?size=#{size}", class: 'mx-2'
    end
end
