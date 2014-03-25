class TextImageWidget < ::Scrival::Migration
  def up
    create_obj_class(
      name: 'TextImageWidget',
      type: 'publication',
      title: 'TextImage',
      attributes: [
        {
          name: 'source',
          type: :reference,
        },
        {
          name: 'align',
          type: :enum,
          values: %w(left right),
        },
        {
          name: 'content',
          type: :html,
        },
      ],
      preset_attributes: {
        align: 'left',
      }
    )
  end
end
