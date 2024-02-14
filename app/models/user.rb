class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :contacts
  has_many :messages
  
  validates_uniqueness_of :name
  #after_create_commit { broadcast_append_to "users" }
  scope :all_except, ->(user) { where.not(id: user.id) }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  def self.from_google(u)
    Rails.logger.debug "User.from_google - Input parameters: #{u.inspect}"
    create_with(uid: u[:uid], provider: 'google',
                password: Devise.friendly_token[0, 20], name: u[:name]).find_or_create_by!(email: u[:email])
  end   
end
