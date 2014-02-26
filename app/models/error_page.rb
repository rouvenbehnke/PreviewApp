class ErrorPage < Page
  # Overrides method +show_breadcrumbs?+ from +Page+.
  def show_breadcrumbs?
    false
  end

  # Overrides method +show_in_navigation?+ from +Page+.
  def show_in_navigation?
    false
  end
end
