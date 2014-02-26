$ ->
  # The "editing" event is only fired, when an editable working copy is selected. The callback
  # allows different styling based on whether the published or an editable working copy is selected.

  infopark.on 'editing', ->
    $('body').addClass('ip_editable_workspace')


  # Activate or deactivate in-place editing.
  #
  # Click on the pen marker to activate in-place editing,
  # click on the menu item 'Deactivate in-place editing' to deactivate it.

  $('a#edit-toggle').on 'click', ->
    if infopark.gui.is_open()
      infopark.gui.close()
    else
      infopark.gui.open()
