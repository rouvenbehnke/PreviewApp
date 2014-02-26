class User
  include ActiveAttr::Model

  attribute :id

  def save
    contact.update_attributes(attributes)
  end

  def logged_in?
    true
  end

  def admin?
    contact.role_names.include?('superuser')
  end

  def contact
    @contact ||= refresh
  end

  def refresh
    @contact = Rails.cache.fetch("contact.#{id}", expires_in: 24.hours, force: true) do
      Infopark::Crm::Contact.find(id)
    end
  end

  def full_name
    [contact.first_name, contact.last_name].join(' ')
  end
end
