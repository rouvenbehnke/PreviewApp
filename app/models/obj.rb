require './lib/rails_connector/cms_definitions'

# This class represents the base class of all CMS objects and implements behavior that all CMS
# objects, regardless whether they are pages or resources have in common.
class Obj < ::RailsConnector::BasicObj
  include RailsConnector::CmsDefinitions

  def self.homepage
    default_homepage
  end

  def self.default_homepage
    Homepage.for_hostname('default')
  end

  def mediabrowser_edit_view_path
    "#{obj_class.underscore}/edit"
  end

  # Determines the homepage for the current object by traversing up the tree
  # until a homepage is found. In case of a ghost path (no parent) the default
  # homepage is returned.
  def homepage
    @homepage ||= if parent
      parent.homepage
    else
      self.class.default_homepage
    end
  end

  def homepages
    website.homepages
  end

  def website
    homepage.website
  end

  # Overriden method +slug+ from +RailsConnector::BasicObj+.
  def slug
    (self[:headline] || '').parameterize
  end

  def locale
    (homepage && homepage[:locale]) || I18n.default_locale
  end
end
