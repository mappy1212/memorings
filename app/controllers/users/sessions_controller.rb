# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new
    #guest用自動ログイン
    if request.fullpath.include?("guest") && !user_signed_in?
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      render "shared/redirect_form" and return
    end
    super
  end
end
