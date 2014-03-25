class SliderWidget < ::Scrival::Migration
  def up
    create_obj_class(
      name: 'SliderWidget',
      type: 'publication',
      title: 'Slider',
      attributes: [
        {
          name: 'images',
          type: :referencelist,
        },
      ]
    )
  end
end
