class User::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  #protect_from_forgery with: :exception
  #skip_before_action :verify_authenticity_token

  def google_oauth2    
    Rails.logger.debug "Omniauth Callback - Google OAuth2: #{auth.inspect}"

    Rails.logger.debug "Redirected to OmniAuth callback URL"

    #Rails.logger.debug "State before redirection: #{state_before_redirect}"
    #Rails.logger.debug "State after redirection: #{state_after_redirect}"
    user = User.from_google(from_google_params)
    
    if user.present?
      sign_out_all_scopes
      flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect user, event: :authentication
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to new_user_session_path
    end
   end

   def failure
    token = form_authenticity_token
    redirect_to root_path
   end

   protected

  def after_omniauth_failure_path_for(_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  def from_google_params
     @from_google_params ||= {
       uid: auth.uid,
       email: auth.info.email,
       name: auth.info.name,
       avatar_url: auth.info.image
     }
   end

  def auth
    @auth ||= request.env['omniauth.auth']
  end

   

 end