class VimeoWidget < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'VimeoWidget',
      type: 'publication',
      title: 'Vimeo',
      attributes: [
        {
          name: 'source',
          type: :linklist,
          max_size: 1,
        },
        {
          name: 'width',
          type: :string,
        },
        {
          name: 'height',
          type: :string,
        },
      ],
      preset_attributes: {
        width: '660',
        height: '430',
      }
    )
  end
end
