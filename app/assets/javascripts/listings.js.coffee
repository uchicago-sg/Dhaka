$(document).ready ->
  # Set number of images in the slider
  images_count = $('.image').length
  if images_count < 3
    sliderQuantity = images_count
  else
    sliderQuantity = 3
  
  $("a#imageLink").fancybox()
  
  $('.images').bxSlider
    infiniteLoop: false
    hideControlOnEnd: true
    displaySlideQty: images_count
    moveSlideQty: 1
    
  $('#subscribe-to-search a').click ->
    $(this).attr('href', $(this).attr('href') + '?' + $('#listing_search').serialize())

  selected_category = $('select#q_categories_id_positive_and_eq option[selected=selected]').text()
  $('#sidebar .category').each ->
    $(this).addClass('active') if $(this).find('a').text() is selected_category