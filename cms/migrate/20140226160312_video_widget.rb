class VideoWidget < ::Scrival::Migration
  def up
    create_obj_class(
      name: 'VideoWidget',
      type: 'publication',
      title: 'Video',
      attributes: [
        {
          name: 'source',
          type: :reference,
        },
        {
          name: 'poster',
          type: :reference,
        },
        {
          name: 'width',
          type: :string,
        },
        {
          name: 'height',
          type: :string,
        },
        {
          name: 'autoplay',
          type: :enum,
          values: %w(Yes No),
        },
      ],
      preset_attributes: {
        width: 660,
        height: 430,
        autoplay: 'No',
      }
    )
  end
end
