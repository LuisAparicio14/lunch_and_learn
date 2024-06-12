class User < ApplicationRecord
  validates_presence_of :name,
                        :email,
                        :api_key,
                        :password_digest

  validates_uniqueness_of :email

  has_secure_password
  has_many :favorites
end