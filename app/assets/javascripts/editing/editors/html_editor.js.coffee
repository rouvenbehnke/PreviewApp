$ ->
  # Configuration and behavior of Redactor html editor. The editor is used for all html CMS
  # attributes and provides autosave, undo and redo functionality on top of the default Redactor
  # settings.

  # Stores the id of the last triggered timeout for later reference.
  timeoutID = undefined

  # Milliseconds after which to save the content automatically.
  autosaveInterval = 3000

  # Stores the last saved content written to the CMS to allow comparison with editor content.
  savedContent = undefined

  # Stores the content before the editor is opened and changes occur.
  originalContent = undefined

  # Stores redactor options, custom settings and configures callbacks.
  redactorOptions = ->
    return {} =
      # This option allows you to add your own buttons with callback to the toolbar.
      # http://imperavi.com/redactor/docs/settings/#set-buttonsCustom
      buttonsCustom:
        undoButton:
          title: 'Undo'
          callback: undoAction
        redoButton:
          title: 'Redo'
          callback: redoAction

      # This setting defines the array of toolbar buttons.
      # http://imperavi.com/redactor/docs/settings/#set-buttons
      buttons: ['undoButton', 'redoButton',
        '|', 'formatting',
        '|', 'bold', 'italic', 'deleted', 'underline',
        '|', 'unorderedlist', 'orderedlist',
        '|', 'table', 'link',
        '|', 'fontcolor', 'backcolor',
        '|', 'html'
      ]

      # This option allows you to set whether Redactor gets cursor focus on load or not.
      # http://imperavi.com/redactor/docs/settings/#set-focus
      focus: true

      # With this option turned on, Redactor will automatically replace divs to paragraphs.
      # http://imperavi.com/redactor/docs/settings/#set-convertDivs
      convertDivs: false

      # This setting turns on email tab in link modal window.
      # http://imperavi.com/redactor/docs/settings/#set-linkEmail
      linkEmail: true

      # This setting allows to turn on and off removing of empty tags.
      # http://imperavi.com/redactor/docs/settings/#set-removeEmptyTags
      removeEmptyTags: false

      # This callback is triggered after Redactor is launched.
      # http://imperavi.com/redactor/docs/callbacks/#callback-initCallback
      initCallback: ->
        originalContent = @get()

      # This callback fires every time when content changes in Redactor.
      # http://imperavi.com/redactor/docs/callbacks/#callback-changeCallback
      changeCallback: ->
        autosaveAction(@)

      # This callback is triggered when Redactor loses focus.
      # http://imperavi.com/redactor/docs/callbacks/#callback-blurCallback
      blurCallback: ->
        @.getBox().addClass('saving')
        saveContents(@).done =>
          @.destroy()

      # This callback is triggered when a key is released.
      # http://imperavi.com/redactor/docs/callbacks/#callback-keyupCallback
      keyupCallback: (event) ->
        event.stopPropagation()
        key = event.keyCode || event.which

        if key == 27
          cancelEditing(@)
        else
          autosaveAction(@)

      # This callback allows to get pasted code after clean on paste.
      # http://imperavi.com/redactor/docs/callbacks/#callback-pasteAfterCallback
      pasteAfterCallback: (html) ->
        autosaveAction(@)
        html

  # Registers a timeout to save the editor content after a certain interval. The timeout gets reset
  # on every change.
  autosaveAction = (editor) ->
    if timeoutID
      clearTimeout(timeoutID)

    timeoutID = setTimeout ( ->
      saveContents(editor)
    ), autosaveInterval

  undoAction = ->
    @execCommand('undo')

  redoAction = ->
    @execCommand('redo')

  # Saves the current editor content to the CMS if it has changed and indicates the saving process.
  saveContents = (editor) ->
    content = editor.get()

    if savedContent != content
      editor.$element.infopark('save', content).done ->
        savedContent = content
      .fail ->
        editor.getBox().removeClass('saving')

    else
      $.Deferred().resolve()

  # Restores the original content before the editor was opened, also saves it back to the CMS
  # because autosave could have overwritten the content and closes the editor.
  cancelEditing = (editor) ->
    editor.set(originalContent)
    saveContents(editor)
    editor.destroy()

  # Registers Redactor for all CMS html attributes found in the given scope of the DOM element.
  addOnclickRedactorHandlers = (domElement) ->
    fields = domElement.find("[data-ip-field-type='html']")

    fields.on 'click', (event) ->
      event.preventDefault()
      cmsField = $(this)

      unless cmsField.hasClass('redactor_editor')
        cmsField.html(cmsField.infopark('content') || '')
        cmsField.redactor(redactorOptions())

  # Registers all handlers when inplace editing is activated.
  infopark.on 'editing', ->
    addOnclickRedactorHandlers($('body'))

  # Registers all handlers when content has changed.
  infopark.on 'new_content', (domElement) ->
    addOnclickRedactorHandlers($(domElement))
