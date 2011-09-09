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
  $('a.fancybox-image').fancybox()

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

  # Showdown.js for live Markdown processing
  converter = new Showdown.converter()

  # If there is anything already in the box, start with that (ie #edit)
  $('.processed-markdown').html converter.makeHtml($('#listing_details').val())

  # and every time something happens
  $('#listing_details').keyup ->
    txt  = $('#listing_details').val()
    html = converter.makeHtml txt
    $('.processed-markdown').html html

  # Before submitting, strip the number formatting added by autoNumeric
  $('form#new_listing').submit ->
    input = $(this).find('input.currency')
    input.val input.val().replace(',','')