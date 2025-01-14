class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :lists, dependent: :destroy
  after_create :create_default_list

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def self.authenticate_by(email_address:, password:)
    user = find_by(email_address: email_address)
    user&.authenticate(password)
  end

  def create_default_list
    self.lists.create(name: 'todo')
    self.lists.create(name: 'Working on it')
    self.lists.create(name: 'Done')
  end
end
