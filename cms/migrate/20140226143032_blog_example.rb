class BlogExample < ::RailsConnector::Migration
  def up
    blog_path = '/website/en/blog'

    create_obj(
      _path: blog_path,
      _obj_class: 'Blog',
      headline: 'Blog',
      disqus_shortname: 'your-disqus-shortname'
    )

    post_path = "#{blog_path}/post-example-1"

    post = create_obj(
      _path: post_path,
      _obj_class: 'BlogPost',
      headline: 'Nulla viverra metus vitae nunc iaculis dignissim',
      author_id: 'admin@example.com',
      author_name: 'Administrator',
      published_at: (Time.zone.now - 1.days).utc.to_iso
    )

    add_widget(Obj.find(post['id']), 'main_content',
      _obj_class: 'TextWidget',
      content: '<p>Quisque eget sem sit amet risus gravida commodo et sed neque. Morbi pellentesque
        urna ut sapien auctor mattis. Donec quis cursus enim. Pellentesque sodales, elit nec
        accumsan congue, orci velit commodo orci, vel luctus nisi mi vitae erat. Cras lacus urna,
        sagittis tristique placerat vel, consectetur id leo. Vestibulum in congue mauris. Donec
        volutpat nibh ut nunc hendrerit porta. Pellentesque habitant morbi tristique senectus et
        netus et malesuada fames ac turpis egestas. Aliquam in felis quis neque aliquet rutrum.
        Morbi interdum aliquet sollicitudin. Curabitur eget erat vitae risus aliquam ultricies ac
        ut leo. Praesent eget lectus lorem, eu luctus velit. Proin rhoncus consequat consectetur.<p>',
    )

    post_path = "#{blog_path}/post-example-2"

    post = create_obj(
      _path: post_path,
      _obj_class: 'BlogPost',
      headline: 'Excepteur sint occaecat cupidatat',
      author_id: 'admin@example.com',
      author_name: 'Administrator',
      published_at: (Time.zone.now - 3.days).utc.to_iso
    )

    add_widget(Obj.find(post['id']), 'main_content',
      _obj_class: 'TextWidget',
      content: '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
        tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
        quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
        consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
        cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
        proident, sunt in culpa qui officia deserunt mollit anim id est laborum.<p>',
    )
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
