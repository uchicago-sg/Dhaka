states = [ 'undisturbed', 'processing', 'validated', 'rejected' ]
submenus = ['#search_tags', '#search_price', '#search_options']

jQuery.fn.foldUp = ->
  $(this).slideUp 500, ->
    $(this).next('.folding').foldUp()

jQuery.fn.foldDown = ->
  $(this).slideDown 500, ->
    $(this).next('.folding').foldDown()


$(document).ready ->
  $('#search_listings .folding').css( 'height', $('#search_listings .folding').height() )
  $('#search_listings .folding').hide()

  hide_button = $('#search_listings .hide')
  hide_button.attr('href', '')
  hide_button.data('collapsed', true)
  hide_button.click (e) ->
    e.preventDefault()
    if $(this).data 'collapsed'
      $(this).text 'Less'
      $('#search_listings .folding').foldDown()
      $(this).data 'collapsed', false
    else
      $(this).text 'More'
      $('#search_listings .folding').foldUp()
      $(this).data 'collapsed', true


  $('#search_listings .responder').each ->
    label = $(this).find('label').hide()
    input = $(this).find('input[type=text]')

    input.data('text',label.text())
    input.val(input.data('text'))
    input.removeClass()
    input.addClass('undisturbed')

    input.focus ->
      $(this).removeClass()
      $(this).val('') if $(this).val() is $(this).data('text')

    input.blur ->
      if $(this).val() is '' or $(this).val() is $(this).data('text')
        $(this).removeClass().addClass('undisturbed').val($(this).data('text'))

  $('#search_listings .submit input').submit ->
    $(this).val('') if $(this).hasClass('undisturbed')
