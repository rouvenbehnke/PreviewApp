class ContactPageExample < ::RailsConnector::Migration
  def up
    create_obj(
      _path: '/website/en/contact',
      _obj_class: 'ContactPage',
      headline: 'Contact',
      crm_activity_type: activity_type
    )

    setup_crm
  end

  private

  def activity_type
    'contact-form'
  end

  def setup_crm
    Infopark::Crm::CustomType.find(activity_type)
  rescue ActiveResource::ResourceNotFound
    custom_attributes = [
      { name: 'email', title: 'Email Adress', type: 'string' },
      { name: 'message', title: 'Message', type: 'text', max_length: 1000 }
    ]

    Infopark::Crm::CustomType.create(
      kind: 'Activity',
      name: activity_type,
      states: %w(open closed),
      icon_css_class: 'omc_activity_23',
      custom_attributes: custom_attributes
    )
  end
end
