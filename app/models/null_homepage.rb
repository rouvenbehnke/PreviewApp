# This file is only used to display an introduction page, in case the current
# working copy does not return a valid homepage object. Usually, you can delete
# this file safely once you first published your content. See
# "app/controllers/null_homepage_controller" and
# "config/initializers/rails_connector.rb" as well.
class NullHomepage < Obj
  def id
    '0'
  end

  def path
    '/null-homepage'
  end

  def obj_class
    'NullHomepage'
  end

  def object_type
    :publication
  end

  def menu_title
    'Welcome to Infopark'
  end
end
