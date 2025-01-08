class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :hashedPassword, presence: true
end
