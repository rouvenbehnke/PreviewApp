class TeaserWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'TeaserWidget',
      type: 'publication',
      title: 'Teaser',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'content',
          type: :html,
        },
        {
          name: 'link_to',
          type: :linklist,
          max_size: 1,
        },
      ]
    )
  end
end
