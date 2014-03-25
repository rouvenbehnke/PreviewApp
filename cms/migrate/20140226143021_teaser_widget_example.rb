class TeaserWidgetExample < Scrival::Migration
  def up
    homepage = Obj.find_by_path('/website/en')

    add_widget(homepage, 'main_content', {
      _obj_class: 'TeaserWidget',
      headline: 'Welcome to scrival',
      content: '<p>You successfully started your
        project. Basic components such as a top navigation, a search panel, this text widget, and a
        login page have been created for you to experiment with the building blocks of your website
        application. To access the documentation or get in touch with the scrival support team,
        visit the Dev Center.</p>',
      link_to: [{
        title: 'Browse scrival Dev Center',
        url: 'https://dev.scrival.net/preparation',
      }],
    })
  end

  private

  def add_widget(obj, attribute, widget_params)
    workspace_id = Scrival::Workspace.current.id
    obj_params = Scrival::CmsRestApi.get("workspaces/#{workspace_id}/objs/#{obj.id}")
    widget_id = Scrival::BasicObj.generate_widget_pool_id

    params = {}
    params['_widget_pool'] = { widget_id => widget_params }
    params[attribute] = obj_params[attribute] || {}
    params[attribute]['list'] ||= []
    params[attribute]['list'] << { widget: widget_id }

    update_obj(obj_params['id'], params)
  end
end
