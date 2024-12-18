class Users::RegistrationsController < Devise::RegistrationsController
  include LocationHelper

  before_action :set_residence_options, only: [:new, :edit]

  def new
    super
  end

  def create
    super do |resource|
      if resource.errors.any? 
        flash[:alert] = I18n.t("devise.registrations.failure")
      end
    end
  end

  private

  def set_residence_options
    @residence = prefectures_and_countries
  end

  def build_resource(hash = {})
    hash[:uid] = User.create_unique_string
    super
  end

  def update_resource(resource, params)
    return super if params['password'].present?
  
    resource.update_without_password(params.except('current_password'))
  end
end