class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :jwt_authenticatable, jwt_revocation_strategy: self
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  before_create :set_jti

  private

  def set_jti
    self.jti = SecureRandom.uuid
  end
end
