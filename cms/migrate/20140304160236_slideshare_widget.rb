class SlideshareWidget < ::Scrival::Migration
  def up
    create_obj_class(
      name: 'SlideshareWidget',
      type: 'publication',
      title: 'Slideshare',
      attributes: [
        {
          name: 'source',
          type: :linklist,
          max_size: 1,
        },
      ]
    )
  end
end
