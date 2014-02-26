class ContactPageController < CmsController
  def index
    @contact_page_presenter = ContactPagePresenter.new(params[:contact_page_presenter])

    if request.post? && @contact_page_presenter.valid?
      ContactActivityService.new(
        @contact_page_presenter.attributes,
        @obj.crm_activity_type
      ).submit

      redirect_to(cms_path(@obj), notice: 'The contact form was sent successfully.')
    end
  end
end
