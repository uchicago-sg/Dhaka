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


states = [ 'undisturbed', 'processing', 'validated', 'rejected' ]
submenus = ['#search_tags', '#search_price', '#search_options']

jQuery.fn.foldUp = ->
  $(this).slideUp 500, ->
    $(this).next('.folding').foldUp()

jQuery.fn.foldDown = ->
  $(this).slideDown 500, ->
    $(this).next('.folding').foldDown()


$(document).ready ->
  # Add folding mechanism
  $('.folding').css( 'height', $('.folding').height() )
  $('.folding').hide()

  hide_button = $('#search_listings .hide')
  hide_button.attr('href', '')
  hide_button.data('collapsed', true)
  hide_button.click (e) ->
    e.preventDefault()
    if $(this).data 'collapsed'
      $(this).text 'Less'
      $('.folding').foldDown()
      $(this).data 'collapsed', false
    else
      $(this).text 'More'
      $('.folding').foldUp()
      $(this).data 'collapsed', true

  # For responsive inputs
  $('.responder').each ->
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

  # Hide mechanism for flashes
  $('#flashes > p').click ->
    $(this).slideUp 500

# $(document).ready(function() {

#
#
#   // Slide mechanism on blocks
#   $('.block').each(function() {
#     details = $(this).find('> div');
#     $(this)
#       .find('> header')
#       .data('collapsed', false)
#       .data('details', details)
#       .click(function() {
#         if ($(this).data('collapsed')) {
#           $(this).data('details').foldDown();
#           $(this).data('collapsed', false);
#         } else {
#           $(this).data('details').foldUp();
#           $(this).data('collapsed', true);
#         }
#       })
#     ;
#   });
#
#
#   // Primary search box behavior
#   var search = {
#     form:   $('#search-form'),
#     label:  $('#search-form label'),
#     input:  $('#search-form input[type=text]'),
#     button: $('#search-form .submit input')
#   };
#
#   search.input.data('text', search.label.text() + '...');
#   search.input.val(search.input.data('text'));
#
#   search.input.focus(function() {
#     $(this).removeClass();
#     search.form.removeClass();
#     if ($(this).val() === $(this).data('text')) {
#       $(this).val('');
#     }
#   });
#
#   search.input.blur(function() {
#     if ($(this).val() === '' || $(this).val() === $(this).data('text')) {
#       $(this).removeClass().addClass('undisturbed').val($(this).data('text'));
#       search.form.addClass('undisturbed');
#     }
#   });
#
#   search.button.submit(function() {
#     if ($(this).hasClass('undisturbed')) {
#       $(this).val('');
#     }
#   });
# });
