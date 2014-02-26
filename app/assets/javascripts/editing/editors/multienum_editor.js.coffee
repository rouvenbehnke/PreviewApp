$ ->
  # Define editor behavior for multienum attributes.

  infopark.on 'editing', ->
    $(document).on 'focusout', '[data-ip-field-type=multienum]', ->
      element = $(@)

      element.infopark('save', element.val())
