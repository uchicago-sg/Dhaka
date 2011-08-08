# IE is really bad at HTML5, so let's help it along...
document.createElement 'header'
document.createElement 'nav'
document.createElement 'section'
document.createElement 'article'
document.createElement 'aside'
document.createElement 'footer'
document.createElement 'figure'
document.createElement 'hgroup'
document.createElement 'detail'
document.createElement 'summary'
document.createElement 'time'

# slideUp a bunch of elements
jQuery.fn.foldUp = ->
  $(this).slideUp 500, ->
    $(this).next('.folding').foldUp()

# slideDown a bunch of elements
jQuery.fn.foldDown = ->
  $(this).slideDown 500, ->
    $(this).next('.folding').foldDown()


$(document).ready ->
  # Hide mechanism for flashes and debug
  $('#flashes > p').click -> $(this).slideUp 500
  $('#debug').click -> $(this).fadeOut()

  $('.currency').numeric { negative: false }

  # # Add folding mechanism
  # $('.folding').hide()
  #
  # # Register handlers for folding
  # hide_button = $('#search_listings .hide')
  # hide_button.attr('href', '')
  # hide_button.data('collapsed', true)
  # hide_button.click (e) ->
  #   e.preventDefault()
  #   if $(this).data 'collapsed'
  #     $(this).text 'Less'
  #     $('.folding').foldDown()
  #     $(this).data 'collapsed', false
  #   else
  #     $(this).text 'More'
  #     $('.folding').foldUp()
  #     $(this).data 'collapsed', true
  #
  # # For responsive inputs
  # $('.responder').each ->
  #   label = $(this).find('label').hide()
  #   input = $(this).find('input[type=text]')
  #
  #   input.data('text',label.text())
  #   input.val(input.data('text'))
  #   input.removeClass()
  #   input.addClass('undisturbed')
  #
  #   input.focus ->
  #     $(this).removeClass()
  #     $(this).val('') if $(this).val() is $(this).data('text')
  #
  #   input.blur ->
  #     if $(this).val() is '' or $(this).val() is $(this).data('text')
  #       $(this).removeClass().addClass('undisturbed').val($(this).data('text'))