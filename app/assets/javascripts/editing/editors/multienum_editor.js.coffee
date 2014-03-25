$ ->
  # Define editor behavior for multienum attributes.

  scrival.on 'editing', ->
    $(document).on 'focusout', '[data-scrival-field-type=multienum]', ->
      element = $(@)

      element.scrival('save', element.val())
