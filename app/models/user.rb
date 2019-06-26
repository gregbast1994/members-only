class User < ApplicationRecord
    before_save :downcase_email

    attr_accessor :remember_token

    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }


    has_secure_password

    def User.new_token
        SecureRandom.urlsafe_base64
    end

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(self.remember_token))
    end

    def forget
        self.remember_token = nil
        update_attribute(:remember_digest, nil)
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    private

    def downcase_email
        email.downcase!
    end
end
