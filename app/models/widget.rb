require './lib/rails_connector/cms_definitions'

# This class represents the base class of all CMS widgets and implements behavior that all CMS
# widgets have in common.
class Widget < ::Scrival::BasicWidget
  include Scrival::CmsDefinitions

  def description
  	obj_class
  end


  def homepage
    obj.homepage
  end
end
