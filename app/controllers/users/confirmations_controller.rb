# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  layout "new_application"

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

  # If the user clicks the confirmation link before the maximum delay,
  # they will be signed in directly.
  def sign_in_after_confirmation?(resource)
    resource.confirmed_at + 2.hours > DateTime.now
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    if sign_in_after_confirmation?(resource)
      sign_in resource
      after_sign_in_path_for(resource_name)
    else
      super(resource_name, resource)
    end
  end
end
