$ ->
  # The accordion widget uses the Twitter Bootstrap 3 panel JavaScrscrivalt. In edit mode, all panels
  # should unfold, so that the editor can manscrivalulate their contents directly.

  scrival.on 'editing', ->
    $('.panel-collapse').collapse('show')
