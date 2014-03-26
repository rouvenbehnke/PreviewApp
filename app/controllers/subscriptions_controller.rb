class SubscriptionsController < ApplicationController
  before_filter :meta, :homepage, :set_locale

  def unsubscribe
    @contact = Infopark::Crm::Contact.find(params[:contact])
    @contact.want_email = false
    @contact.save
    @a = Infopark::Crm::Activity.create(
        contact_id: @contact.id, 
        title: "Unsubscribe",
        kind: "note", 
        state: "open")
  end

  def confirmation
    unless params[:unsub].nil?
      a = Infopark::Crm::Activity.find(params[:unsub][:activity])
      a.comment_contact_id = a.contact_id
      a.comment_notes = params[:unsub][:reason]
      a.comment_published = false
      a.save
      redirect_to unsubscribe_confirmation_path(locale: params[:params][:locale])
    end
    
  end

  private
  def meta
    set_meta_tags :noindex => true
  end

  def homepage
    @obj = Obj.find("dd447003a7ebc532")
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
