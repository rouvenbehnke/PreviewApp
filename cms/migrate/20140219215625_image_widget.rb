class ImageWidget < ::Scrival::Migration
  def up
    create_obj_class(
      name: 'ImageWidget',
      type: 'publication',
      title: 'Image',
      attributes: [
        {
          name: 'source',
          type: :reference,
        },
        {
          name: 'align',
          type: :enum,
          values: %w(left center right),
        },
      ],
      preset_attributes: {
        align: 'left',
      }
    )
  end
end
