class CmsController < Scrival::DefaultCmsController
  include HostnameSelection

  # Delay filter until the Scrival has loaded the current object.
  skip_before_filter :set_locale
  before_filter :set_locale
end
