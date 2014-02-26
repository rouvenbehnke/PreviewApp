class Homepage < Page
  # TODO edit mapping from hostnames to homepages
  def self.for_hostname(hostname)
    find_by_path('/website/en')
  end

  # TODO edit mapping from homepages to hostnames
  # Inverse of .for_hostname
  def desired_hostname
    'www.website.com'
  end

  def homepage
    self
  end

  def website
    parent
  end

  # Overriden method +show_breadcrumbs?+ from +Page+.
  def show_breadcrumbs?
    false
  end
end
