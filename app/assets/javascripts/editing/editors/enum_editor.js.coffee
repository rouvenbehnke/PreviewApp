$ ->
  # Define editor behavior for enum attributes.

  infopark.on 'editing', ->
    $(document).on 'focusout', '[data-ip-field-type=enum]', ->
      element = $(@)

      element.infopark('save', element.val())
