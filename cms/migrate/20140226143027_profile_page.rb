class ProfilePage < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'ProfilePage',
      type: 'publication',
      title: 'Profile',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )
  end
end
