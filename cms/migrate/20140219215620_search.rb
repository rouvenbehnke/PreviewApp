class Search < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'SearchPage',
      type: 'publication',
      title: 'Search',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )
  end
end
