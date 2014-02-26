$ ->
  # Define editor behavior for date attributes.

  infopark.on 'editing', () ->
    cmsEditDates = $('[data-ip-field-type=date]')

    for cmsEditDate in cmsEditDates
      dateField = $(cmsEditDate).find('input[type=text]')

      $(dateField).datepicker(format: 'yyyy-mm-dd').on 'hide', (event) ->
        date = event.date

        # Set date hour to 12 to work around complex time zone handling.
        date.setHours(12)

        cmsField = $(@).closest('[data-ip-field-type=date]')
        cmsField.infopark('save', date)
