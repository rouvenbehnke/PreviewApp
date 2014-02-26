class ContactPage < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'ContactPage',
      type: 'publication',
      title: 'Contact',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'crm_activity_type',
          type: :string,
        },
      ]
    )
  end
end
