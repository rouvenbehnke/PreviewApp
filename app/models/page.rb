# This base class provides behavior that all CMS pages have in common. It is
# similar to a +Widget+, as it allows to add behavior by inheritance.
class Page < Obj
  # By default pages display a breadcrumb navigation. Either add a
  # boolean cms attribute +show_breadcrumbs+ or override the method directly
  # in your page model.
  def show_breadcrumbs?
    true
  end

  # Returns all breadcrumb pages. A breadcrumb page must be a +Page+ and needs
  # to allow to be displayed in the navigation. Both +Root+ and +Website+ are
  # not pages, so only pages up to the homepage are displayed.
  def breadcrumbs
    list = ancestors.select { |obj| obj.respond_to?(:show_in_navigation?) && obj.show_in_navigation? }
    list + [self]
  end

  # By default, objects can be displayed in navigation sections. Either add a
  # boolean cms attribute +show_in_navigation+ or override the method directly
  # in your model.
  def show_in_navigation?
    true
  end

  def menu_title
    self[:headline] || '[no headline]'
  end
end
