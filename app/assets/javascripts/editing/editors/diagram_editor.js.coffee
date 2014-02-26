$ ->
  diagramEditorTemplate = (barsData) ->
    editor = $('<div></div>')
      .addClass('diagram-editor')

    barsEditorTemplate(barsData)
      .appendTo(editor)

    addButtonTemplate()
      .appendTo(editor)

    editor

  barsEditorTemplate = (barsData) ->
    list = $('<ul></ul>')
      .addClass('list-unstyled')

    for barData in barsData
      title = barData['title']
      value = barData['value']

      barEditorTemplate(title, value)
        .appendTo(list)

    list.sortable
      update: (event) ->
        save()

  barEditorTemplate = (title, value) ->
    item = $('<li></li>')

    titleInputTemplate(title)
      .appendTo(item)

    valueInputTemplate(value)
      .appendTo(item)

    deleteButtonTemplate()
      .appendTo(item)

    item

  titleInputTemplate = (title) ->
    title ||= ''

    $('<input />')
      .attr('type', 'text')
      .attr('name', 'title')
      .attr('value', title)
      .attr('placeholder', 'Title')

  valueInputTemplate = (value) ->
    value ||= ''

    $('<input />')
      .attr('type', 'number')
      .attr('name', 'value')
      .attr('value', value)
      .attr('placeholder', 'Value')
      .attr('min', '1')
      .attr('max', '100')
      .attr('step', '1')

  deleteButtonTemplate = ->
    link = $('<a></a>')
      .addClass('editing-button')
      .addClass('editing-red')
      .addClass('delete')
      .attr('href', '#')

    icon = $('<i></i>')
      .addClass('editing-icon')
      .addClass('editing-icon-trash')
      .appendTo(link)

    link

  addButtonTemplate = ->
    link = $('<a></a>')
      .addClass('editing-button')
      .addClass('editing-green')
      .addClass('add')
      .attr('href', '#')

    icon = $('<i></i>')
      .addClass('editing-icon')
      .addClass('editing-icon-plus')
      .appendTo(link)

    link

  diagramEditor = ->
    $('.diagram-editor')

  addBarEditor = (event) ->
    event.preventDefault()

    barEditorList = diagramEditor()
      .find('ul')

    barEditorElement = barEditorTemplate('', '')
      .appendTo(barEditorList)

  removeBarEditor = (event) ->
    event.preventDefault()

    $(event.currentTarget)
      .closest('li')
      .remove()

    save()

  save = ->
    data = serialize()

    diagramEditor()
      .data('cmsField')
      .infopark('save', data)

  serialize = ->
    elements = diagramEditor().find('li')
    barsData = []

    for element in elements
      element = $(element)

      barsData.push
        title: element.find('[name="title"]').val()
        value: element.find('[name="value"]').val()

    serializer = new DiagramSerializer
    serializer.serialize(barsData)

  # The diagram editor is initialized when the widget property window is opened. It is based on a
  # CMS string field. The editor also makes sure, that changes are saved to the CMS and that the
  # diagram is reloaded if changes occur.
  infopark.on 'new_content', (root) ->
    diagramSourceElement = $(root).find('.diagram-source')
    new Diagram(diagramSourceElement).init()

    element = $(root).find('.diagram-editor-source')

    if element? && element.length > 0
      serializer = new DiagramSerializer
      sourceData = element.text()
      barsData = serializer.parse(sourceData)
      diagramEditorElement = diagramEditorTemplate(barsData)
        .data('cmsField', element)
        .on 'click', '.add', addBarEditor
        .on 'click', '.delete', removeBarEditor
        .on 'focusout', 'input', save
        .insertAfter(element)
