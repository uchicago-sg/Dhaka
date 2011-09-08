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

  # Add behavior to "More or Less" link on the listing browser
  $('#listings-browser .listing').each ->
    listing = $(this)
    toggle  = listing.find '.toggle a'
    details = listing.find '.truncated-details'
    extras  = listing.find '.extras'

    toggle.click (e) ->
      details.toggle()
      extras.toggle()
      if $(this).hasClass 'show-more'
        $(this).removeClass('show-more').addClass('show-less').text('Less')
      else
        $(this).removeClass('show-less').addClass('show-more').text('More')

  # Highlight the current category in the sidebar if selected in simple search form
  if $('#listings.index').exists()
    selected_category = $('select#q_categories_id_positive_and_eq option[selected=selected]').text()
    $('#sidebar .category').each ->
      $(this).addClass('selected') if $(this).find('a').text() is selected_category

  # Hide image upload inputs, and allow the user to reveal them
  if $('#listings.new').exists() or $('#listings.edit').exists()
    $('.image-upload').hide()
    $('.image-upload').first().show()
    $('#add-image a').click ->
      $('.image-upload:visible').last().next().show()
      if $('.image-upload').size() is $('.image-upload:visible').size() then $(this).remove()
      false

  # Add search form behavior
  listing_search_form = $('form#listing_search')
  listing_search_form.find('.inside_label').each ->
    input = $(this).find 'input'
    label = $(this).find 'label'
    input.data 'default_text', label.text()

    input.focus ->
      if $(this).val() is $(this).data('default_text')
        $(this).removeClass()
        $(this).val ''

    input.blur ->
      if $(this).val() is ''
        $(this).addClass 'undisturbed'
        $(this).val $(this).data('default_text')

    listing_search_form.submit -> input.focus()
    input.blur()

  # Limit the price input
  $('.currency').autoNumeric()