class OmniauthCallbacksController < ApplicationController

  def twitter
    omniauth = request.env['omniauth.auth']

    Rails.logger.warn "**** OMNIAUTH ****"
    Rails.logger.warn "#{omniauth.inspect}"

    uid = omniauth.uid
    username = omniauth.info.nickname
    provider = omniauth.provider
    access_token = omniauth.credentials.token
    access_token_secret = omniauth.credentials.secret

    user = User.find_by_uid(uid)
    user ||= User.create(
      provider: provider,
      uid: uid,
      username: username,
      twitter_access_token: access_token,
      twitter_access_token_secret: access_token_secret)

    sign_in(user)
    redirect_to dashboard_path
  end

  def failure
    flash[:alert] = params.inspect
    redirect_to root_path
  end

end
