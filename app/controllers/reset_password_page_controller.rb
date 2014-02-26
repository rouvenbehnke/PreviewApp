class ResetPasswordPageController < CmsController
  def index
    if request.post?
      contact = Infopark::Crm::Contact.search(params: { login: user_params[:login] }).first

      if contact && contact.password_request
        redirect_to(cms_path(@obj.homepage), notice: 'Password reset successfully. You receive an email with further instructions.')
      else
        flash[:alert] = 'Password reset failed. Please try it again.'
      end
    end
  end

  private

  def user_params
    params[:user]
  end
end
