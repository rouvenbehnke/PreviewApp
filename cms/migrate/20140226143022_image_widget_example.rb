require 'open-uri'

class ImageWidgetExample < RailsConnector::Migration
  def up
    homepage = Obj.find_by_path('/website/en')

    asset_url = 'http://lorempixel.com/1170/400/abstract'

    asset = create_obj({
      _obj_class: 'Image',
      _path: "_resources/#{SecureRandom.hex(8)}/example_image.jpg",
      blob: upload_file(open(asset_url)),
    })

    add_widget(homepage, 'main_content', {
      _obj_class: 'ImageWidget',
      source: asset['id'],
    })
  end

  private

  def add_widget(obj, attribute, widget_params)
    workspace_id = RailsConnector::Workspace.current.id
    obj_params = RailsConnector::CmsRestApi.get("workspaces/#{workspace_id}/objs/#{obj.id}")
    widget_id = RailsConnector::BasicObj.generate_widget_pool_id

    params = {}
    params['_widget_pool'] = { widget_id => widget_params }
    params[attribute] = obj_params[attribute] || {}
    params[attribute]['list'] ||= []
    params[attribute]['list'] << { widget: widget_id }

    update_obj(obj_params['id'], params)
  end
end
