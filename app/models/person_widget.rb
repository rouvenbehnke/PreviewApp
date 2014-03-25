class PersonWidget < Widget
  # Overrides CMS getter method +person+.
  def person
    person = self[:person] || ''

    if person.present?
      @person ||= Scrival::Crm::Contact.search(params: { login: person }).first
      @person ||= Scrival::Crm::Contact.search(params: { email: person }).first
    end
  end
end
