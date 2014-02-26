class HeadlineWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'HeadlineWidget',
      type: 'publication',
      title: 'Headline',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'anchor',
          type: :string,
        },
      ]
    )
  end
end
