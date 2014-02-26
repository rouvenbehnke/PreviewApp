class Kickstart < ::RailsConnector::Migration
  def up
    create_obj_class(
      name: 'Video',
      type: 'generic',
      title: 'Video',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
      ]
    )

    create_obj_class(
      name: 'Root',
      type: 'publication',
      title: 'Root'
    )

    create_obj_class(
      name: 'Homepage',
      type: 'publication',
      title: 'Homepage',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'main_content',
          type: :widget,
        },
        {
          name: 'error_not_found_page',
          type: :reference,
        },
        {
          name: 'locale',
          type: :string,
        },
      ]
    )

    create_obj_class(
      name: 'Website',
      type: 'publication',
      title: 'Website'
    )

    create_obj_class(
      name: 'ContentPage',
      type: 'publication',
      title: 'Content',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'main_content',
          type: :widget,
        },
        {
          name: 'sidebar_content',
          type: :widget,
        },
      ]
    )

    create_obj_class(
      name: 'ErrorPage',
      type: 'publication',
      title: 'Error',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'main_content',
          type: :widget,
        },
      ]
    )
  end
end
