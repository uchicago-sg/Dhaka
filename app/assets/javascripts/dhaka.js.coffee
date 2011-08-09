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

$(document).ready ->
  # Hide mechanism for flashes and debug
  $('#flashes > p').click -> $(this).slideUp 500
  $('#debug').click -> $(this).fadeOut()
  $('.currency').numeric { negative: false }
  $('.time-ago').attr('title', '').timeago()