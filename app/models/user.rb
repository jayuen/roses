class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:google_oauth2]
   
  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create! do |u|
        u.password = Devise.friendly_token[0,20]
        u.provider = auth.provider
        u.uid = auth.uid
        u.name = auth.info.name
        u.email = auth.info.email
      end
    end
  end
end
