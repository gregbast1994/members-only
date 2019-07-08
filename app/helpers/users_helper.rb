module UsersHelper
    def gravatar_for(user, size="50")
        digest = Digest::MD5.hexdigest(user.email)
        image_tag "https://www.gravatar.com/avatar/#{digest}?size=#{size}", class: 'gravatar img-fluid img-thumbnail'
    end
  
end
