class Users::RegistrationsController < Devise::RegistrationsController
  before_action :check_guest, only: :destroy

  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは削除できません'
    end
  end

  protected
    def after_update_path_for(resource)
      user_path(resource)
    end
end