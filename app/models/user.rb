class User < ApplicationRecord
    before_save :downcase_email

    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }


    has_secure_password

    private

    def downcase_email
        email.downcase!
    end
end