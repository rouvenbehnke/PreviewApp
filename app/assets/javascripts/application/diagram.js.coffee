$ ->
  # The DiagramSerializer is a helper class to combine the parse and serialize
  # logic, so that it can be used by both the diagram and the diagram editor. It
  # can parse a string or turn a hash back into a string. The class is globally
  # available.
  class window.DiagramSerializer
    parse: (source) ->
      bars = []

      for bar in source.split('|')
        [title, value] = bar.split(/\s*,\s*/)

        if title? and value?
          bars.push
            title: title
            value: value

      bars

    serialize: (barsData) ->
      output = []

      for barData in barsData
        title = barData['title']
        value = barData['value']

        output.push "#{title},#{value}"

      output.join('|')

  # The Diagram class holds the logic to display a set of progressbars each with
  # a title and a percentage. It uses the Twitter Bootstrap progressbars and is
  # based on a CMS string attribute.
  class window.Diagram
    constructor: (@element) ->
      @serializer = new DiagramSerializer

    init: ->
      if @element? && @element.length > 0
        for element in @element
          element = $(element)
          sourceData = element.text()
          barsData = @serializer.parse(sourceData)

          @diagramTemplate(barsData)
            .insertAfter(element)

    diagramTemplate: (barsData) ->
      diagramElement = $('<div></div>')
        .addClass('diagram')

      for barData in barsData
        labelElement = @labelTemplate(barData['title'])
        progressbarElement = @progressbarTemplate(barData['value'])

        diagramElement
          .append(labelElement)
          .append(progressbarElement)

      diagramElement

    labelTemplate: (title) ->
      $('<h3></h3>')
        .text(title)

    progressbarTemplate: (percent) ->
      wrapper = $('<div></div>')
        .addClass('progress')

      bar = $('<div></div>')
        .addClass('progress-bar')
        .addClass('progress-bar-success')
        .attr('role', 'progressbar')
        .attr('aria-valuemin', '0')
        .attr('aria-valuemax', '100')
        .attr('aria-valuenow', percent)
        .css('width', "#{percent}%")
        .appendTo(wrapper)

      wrapper

  new Diagram($('.diagram-source')).init()
