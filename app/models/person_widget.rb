class PersonWidget < Widget
  # Overrides CMS getter method +person+.
  def person
    person = self[:person] || ''

    if person.present?
      @person ||= Infopark::Crm::Contact.search(params: { login: person }).first
      @person ||= Infopark::Crm::Contact.search(params: { email: person }).first
    end
  end
end
