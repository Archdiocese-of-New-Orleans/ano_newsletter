class AnoNewsletter::ApplicationController < ApplicationController

  before_filter :auth

  private

  def auth
    p ano_newsletter_current_user
    p ano_newsletter_authorize!
    # ano_newsletter_current_user = true if Rails.env.development?
    if ano_newsletter_current_user || ![:index, :show].include?(action_name.to_sym)
      ano_newsletter_authorize!
    end
  end

  def ano_newsletter_current_user
    instance_eval &AnoNewsletter.current_user_method
  end

  def ano_newsletter_authorize!
    instance_eval &AnoNewsletter.authorize_with
  end
end