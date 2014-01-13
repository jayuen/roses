class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Signed in Through Google!"
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      flash.notice = "You are almost Done! Please provide a password to finish setting up your account"
      redirect_to new_user_registration_url
    end
  end

  def after_sign_in_path_for(resource)
    season = Season.where(current: true).first
    player = season.players.where(user_id: resource.id).first

    if player.nil?
      player = Player.create! season_id: season.id, user_id: resource.id
    end

    player_path(player)
  end
end
