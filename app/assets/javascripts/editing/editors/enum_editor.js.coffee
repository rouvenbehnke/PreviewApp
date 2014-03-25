$ ->
  # Define editor behavior for enum attributes.

  scrival.on 'editing', ->
    $(document).on 'focusout', '[data-scrival-field-type=enum]', ->
      element = $(@)

      element.scrival('save', element.val())
