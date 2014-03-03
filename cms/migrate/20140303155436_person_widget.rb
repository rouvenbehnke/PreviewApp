class PersonWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'PersonWidget',
      type: 'publication',
      title: 'Person',
      attributes: [
        {
          name: 'person',
          type: :string,
        },
      ]
    )
  end
end
