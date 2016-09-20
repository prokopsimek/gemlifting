class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(auth_hash)
    sign_in_and_redirect @user
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
