$(document).ready ->
  $('.images').bxSlider
    infiniteLoop: false
    hideControlOnEnd: true

  $('#subscribe-to-search a').click ->
    $(this).attr('href', $(this).attr('href') + '?' + $('#listing_search').serialize())