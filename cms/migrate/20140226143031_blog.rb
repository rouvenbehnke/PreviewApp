class Blog < ::Scrival::Migration
  def up
    create_obj_class(
      name: 'Blog',
      type: 'publication',
      title: 'Blog',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'disqus_shortname',
          type: :string,
        },
      ]
    )

    create_obj_class(
      name: 'BlogPost',
      type: 'publication',
      title: 'Blog Post',
      attributes: [
        {
          name: 'headline',
          type: :string,
        },
        {
          name: 'author_id',
          type: :string,
        },
        {
          name: 'author_name',
          type: :string,
        },
        {
          name: 'main_content',
          type: :widget,
        },
        {
          name: 'published_at',
          type: :date,
        },
      ]
    )
  end
end
