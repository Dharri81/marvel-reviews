class User < ActiveRecord::Base
    has_many :reviews
    has_secure_password
  
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true
end

