#= require tinymce-jquery

$(document).ready ->
  # Redirect the user to the Atom feed by passing in the serialized advanced search form
  $('#subscribe-to-search a').click ->
    $(this).attr('href', $(this).attr('href') + '?' + $('#listing_search .input > *').serialize())

  # Create an image carousel
  $('.show .images').bxSlider
    infiniteLoop: false
    hideControlOnEnd: true
    displaySlideQty: if $('.image').length > 3 then 3 else $('.image').length
    moveSlideQty: 1

  # Open an image in the Fancybox
  $('a.fancybox-image').fancybox
    centerOnScroll: true

  # Highlight the current category in the sidebar if selected in simple search form
  if $('#listings.index').exists()
    selected_category = $('select#q_categories_id_positive_and_eq option[selected=selected]').text()
    $('#sidebar .category').each ->
      $(this).addClass('selected') if $(this).find('a').text() is selected_category

  # Limit the price input
  $('.currency').autoNumeric()

  # Hide image upload inputs, and allow the user to reveal them
  if $('#listings.new').exists() or $('#listings.edit').exists()
    $('.image-upload').hide()
    $('.image-upload').first().show()
    $('#add-image a').click ->
      $('.image-upload:visible').last().next().show()
      if $('.image-upload').size() is $('.image-upload:visible').size() then $(this).remove()
      false

  $('textarea').tinymce
    theme: 'advanced'
    theme_advanced_toolbar_location: 'top'
    theme_advanced_buttons1: 'undo,redo,separator,bold,italic,underline,separator,bullist,numlist,outdent,indent,separator,link,unlink'
    theme_advanced_buttons2: ''
    theme_advanced_buttons3: ''

  # Before submitting, strip the number formatting added by autoNumeric
  $('form#new_listing').submit ->
    input = $(this).find('input.currency')
    input.val input.val().replace(',','')