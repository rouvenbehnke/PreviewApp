require './lib/rails_connector/cms_definitions'

# This class represents the base class of all CMS widgets and implements behavior that all CMS
# widgets have in common.
class Widget < ::RailsConnector::BasicWidget
  include RailsConnector::CmsDefinitions

  def homepage
    obj.homepage
  end
end
