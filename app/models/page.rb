# This base class provides behavior that all CMS pages have in common. It is
# similar to a +Widget+, as it allows to add behavior by inheritance.
class Page < Obj
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
