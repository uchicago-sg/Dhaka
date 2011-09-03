$(document).ready ->
  # Set number of images in the slider
  images_count = $('.image').length
  if images_count < 3
    sliderQuantity = images_count
  else
    sliderQuantity = 3
    
  # Fancybox the image link
  $("a#image-link").fancybox()
  
  $('.images').bxSlider
    infiniteLoop: false
    hideControlOnEnd: true
    displaySlideQty: images_count
    moveSlideQty: 1

  # Redirect the user to the Atom feed by passing in the serialized advanced search form
  $('#subscribe-to-search a').click ->
    $(this).attr('href', $(this).attr('href') + '?' + $('#listing_search .input > *').serialize())

  # Highlight the current category in the sidebar if selected in simple search form
  if $('#listings.index').exists()
    selected_category = $('select#q_categories_id_positive_and_eq option[selected=selected]').text()
    $('#sidebar .category').each ->
      $(this).addClass('active') if $(this).find('a').text() is selected_category
  
  if $('.images-block').exists()
    $('.image-upload').hide()
    $('.image-upload').first().show()
  
  # Needs some work
  $('span#add-image a').click -> 
    $('.image-upload:visible').last().next().show()
    return false
    