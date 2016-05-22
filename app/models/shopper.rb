class Shopper < ActiveRecord::Base
  include BCrypt

  validates :email, presence: true
  validates :password_hash, presence: true

  has_one :wishlist
  has_many :offers

  def self.authenticate(email, password)
    s = self.where(email: email).first
    if s && s.password == password
      s
    end
  end

  def password
    Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end
end
