class EventsController < ApplicationController
  before_filter :meta, :homepage, :set_locale
  def invitation
    @event = Infopark::Crm::Event.find(params[:event])
    @contact = Infopark::Crm::Contact.find(params[:contact])
  end

  def create
    @event = Infopark::Crm::Event.find(params[:params][:event])
    @contact = Infopark::Crm::Contact.find(params[:params][:contact])
    ec = Infopark::Crm::EventContact.create(
        contact_id: @contact.id, 
        event_id: @event.id, 
        state: params[:state])
    if ec.valid?
      comment = "First name: #{params[:infopark_crm_contact][:first_name]}\n" +
                "Last name: #{params[:infopark_crm_contact][:last_name]}\n" + 
                "Email: #{params[:infopark_crm_contact][:email]}\n" + 
                "Phone: #{params[:infopark_crm_contact][:phone]}\n" + 
                "State: #{params[:state]}"
      a = Infopark::Crm::Activity.create(
        contact_id: @contact.id, 
        title: "Event response for #{@event.title}", 
        kind: "event_inv_response", 
        state: "open",
        custom_invited: (params[:params][:extern].blank?) ? "internal" : "external",
        custom_state: params[:state],
        custom_event: @event.id,
        comment_contact_id: @contact.id,
        comment_notes: comment,
        comment_published: true)
        unless params[:guest][:email].blank?
          guest = new_or_known(params[:guest])
          create_invitation(guest, @contact, @event)
        end
        redirect_to event_invitation_confirmation_path(contact: @contact, locale: params[:params][:locale])
    else
      redirect_to event_invitation_already_path(contact: @contact, locale: params[:params][:locale])
    end
  end

  def already
    @contact = Infopark::Crm::Contact.find(params[:contact])
  end

  def confirmation
    @contact = Infopark::Crm::Contact.find(params[:contact])
  end

  def ics
    event = Infopark::Crm::Event.find(params[:event])
    cal =RiCal.Calendar do
      event do
        summary event.title
        description event.title
        dtstart DateTime.parse(event.dtstart_at)
        dtend DateTime.parse(event.dtend_at)
        location event.location
      end
    end
      respond_to do |format|
      format.ics { send_data(cal.export, :filename=>"#{event.title}.ics", :disposition=>"inline; filename=#{event.title}.ics", :type=>"text/calendar")}
    end
  end

  private

  def new_or_known(params)
    g = Infopark::Crm::Contact.search(:params => {:email => params[:email]}).first
    if g.nil?
      g = Infopark::Crm::Contact.create(
          first_name: params[:first_name], 
          last_name: params[:last_name],
          gender: params[:gender],
          language: "de",
          phone: params[:phone],
          email: params[:email])
    end
    return g
  end

  def create_invitation(guest, contact, event)
    a = Infopark::Crm::Activity.create(
        contact_id: guest.id, 
        title: "External Invitation to #{event.title}",
        kind: "external_event_inv",
        custom_event: event.id,
        custom_by: "#{contact.last_name}, #{contact.first_name}",
        custom_by_id: contact.id,
        comment_contact_id: contact.id,
        comment_notes: "Send invitation",
        comment_published: true)
  end

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
