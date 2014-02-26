$ ->
  # This file integrates a simple text input field to edit string attributes.

  timeout = undefined

  infopark.on 'editing', ->
    template = ->
      editor = $('<div></div>')
        .addClass('text-editor')

      input = $('<textarea />')
        .attr('rows', '6')
        .appendTo(editor)

      editor

    getBox = (element) ->
      element.closest('.text-editor')

    editMarker = (cmsField) ->
      cmsField.closest('[data-ip-private-widget-obj-class]').find('.ip_editing_marker')

    disableEditMode = (box) ->
      cmsField = box.data('cmsField')

      cmsField.show()
      editMarker(cmsField).show()
      box.remove()

    keyUp = (event) ->
      event.stopPropagation()
      key = event.keyCode || event.which

      if timeout
        clearTimeout(timeout)

      switch key
        when 27 # Esc
          cancel(event)
        else
          timeout = setTimeout ( ->
            save(event)
          ), 3000

    save = (event, closeInput = false) ->
      inputField = $(event.currentTarget)
      content = inputField.val()
      box = getBox(inputField)
      cmsField = box.data('cmsField')

      if timeout
        clearTimeout(timeout)

      if closeInput
        box.addClass('saving')

      cmsField.infopark('save', content).done ->
        if closeInput
          cmsField.html(content)
          disableEditMode(box)
      .fail ->
        box.removeClass('saving')

    cancel = (event) ->
      box = getBox($(event.currentTarget))

      disableEditMode(box)

    onBlur = (event) ->
      save(event, true)

    $('body').on 'click', '[data-ip-field-type=text]', (event) ->
      event.preventDefault()
      event.stopPropagation()

      cmsField = $(this)

      template()
        .data('cmsField', cmsField)
        .insertAfter(cmsField)
        .find('textarea')
        .val(cmsField.infopark('content') || '')
        .focusout(onBlur)
        .keyup(keyUp)
        .focus()

      cmsField.hide()
      editMarker(cmsField).hide()
