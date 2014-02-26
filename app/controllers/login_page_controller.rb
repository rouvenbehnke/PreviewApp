class LoginPageController < CmsController
  def index
    if request.post?
      contact = Infopark::Crm::Contact.authenticate(user_params[:login], user_params[:password])
      self.current_user = User.new(id: contact.id)

      target = params[:return_to] || cms_path(@obj.homepage)
      redirect_to(target, notice: 'You logged in successfully.')
    elsif request.delete?
      discard_user
      redirect_to(cms_path(@obj.homepage), notice: 'You logged out successfully.')
    end
  rescue Infopark::Crm::Errors::AuthenticationFailed, ActiveResource::ResourceInvalid
    flash[:alert] = 'Log in failed. Please try it again.'
  end

  private

  def user_params
    params[:user]
  end
end
