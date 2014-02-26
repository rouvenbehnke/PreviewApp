@MediabrowserInspector = do ->
  inspectorSelector: '.editing-mediabrowser-inspector'
  contentSelector: '.inspector-content'
  modalBodySelector: '.editing-mediabrowser-body'
  inspector: undefined
  objectId: undefined

  _initializeBindings: ->
    modalBody = $(@modalBodySelector)

    modalBody.on 'click', 'li.mediabrowser-item', (event) =>
      @_onInspect(event)

    modalBody.on 'click', 'a.inspector-close', (event) =>
      event.preventDefault()
      @close()

    @inspector = @modal.find(@inspectorSelector)
    @inspector.hide()

  _onInspect: (event) ->
    unless $(event.target).hasClass('select-item')
      currentTarget = $(event.currentTarget)
      id = currentTarget.data('id')

      if id
        @open(id)
        @_highlightItem(currentTarget)

  _renderLoading: ->
    @inspector.html(@_loadingTemplate())

  _loadingTemplate: ->
    icon = $('<i></i>')
      .addClass('editing-icon editing-icon-refresh')

    $('<div></div>')
      .addClass('editing-mediabrowser-loading')
      .html(icon)

  _highlightItem: (element) ->
    @modal.find('li.mediabrowser-item.active').removeClass('active')
    element.addClass('active')

  init: (modal) ->
    @modal = modal
    @_initializeBindings()

  # Opens the inspector section in the mediabrowser for the given object ID and displays its edit
  # view.
  open: (objectId) ->
    @objectId = objectId

    @inspector.show()
    @_renderLoading()

    $.ajax
      url: '/mediabrowser/inspector'
      dataType: 'json'
      data:
        id: @objectId
      success: (json) =>
        @inspector.html(json.content)
        infopark.trigger('new_content', @inspector)

      error: =>
        @inspector.empty()

  # Closes the inspector section of the mediabrowser.
  close: ->
    @inspector.empty()
    @inspector.hide()
