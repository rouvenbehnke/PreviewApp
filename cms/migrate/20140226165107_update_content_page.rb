class UpdateContentPage < ::RailsConnector::Migration
  def up
    # get_obj_class('Test')
    # create_obj_class(name: 'Test', type: :publication, attributes: [])
    # update_obj_class('Test', title: 'Test Title')
    add_attribute_to('ContentPage', { name: 'inhalttest', type: 'html' })
    # update_attribute_for('Test', 'test', { title: 'New Title' })
    # delete_attribute_from('Test', 'test')

    # get_obj('a1b2c3')
    # create_obj(_path: '/test', _obj_class: 'Test')
    # update_obj('a1b2c3', title: 'Test Title')
    # delete_obj('a1b2c3')
  end
end