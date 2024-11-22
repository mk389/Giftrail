class Users::RegistrationsController < Devise::RegistrationsController
  include LocationHelper

  before_action :set_residence_options, only: [:new, :edit]

  def new
    super
  end

  def create
    super do |resource|
      if resource.errors.any? # もしエラーがあれば
        flash[:alert] = I18n.t("devise.registrations.failure")
      end
    end
  end

  private

  def set_residence_options
    @residence = prefectures_and_countries
  end
end