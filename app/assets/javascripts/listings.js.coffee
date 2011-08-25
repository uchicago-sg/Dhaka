$(document).ready ->
  $('.images').bxSlider
    infiniteLoop: false
    hideControlOnEnd: true

  $('#subscribe-to-search a').click ->
    $(this).attr('href', $(this).attr('href') + '?' + $('#listing_search').serialize())

  selected_category = $('select#q_categories_id_positive_and_eq option[selected=selected]').text()
  $('#sidebar .category').each ->
    $(this).addClass('active') if $(this).find('a').text() is selected_category