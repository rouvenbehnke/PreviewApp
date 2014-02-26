class SearchExample < ::RailsConnector::Migration
  def up
    search_page = create_obj(
      _path: '/website/en/_configuration/search',
      _obj_class: 'SearchPage',
      headline: 'Search'
    )

    add_attribute_to('Homepage', {
      name: 'search_page',
      type: :reference,
      title: 'Search Page',
    })

    update_obj(
      Obj.find_by_path('/website/en').id,
      search_page: search_page['id']
    )
  end
end
