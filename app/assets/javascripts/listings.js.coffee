#= require tinymce-jquery

$(document).ready ->
  # Redirect the user to the Atom feed by passing in the serialized advanced search form
  $('#subscribe-to-search a').click ->
    $(this).attr('href', $(this).attr('href') + '?' + $('#listing_search .input > *').serialize())
  
  # Create slider
  slider = $(".show .images").bxSlider(controls: false)
  $(".thumbs a").click ->
    thumbIndex = $(".thumbs a").index(this)
    slider.goToSlide thumbIndex
    $(".thumbs a").removeClass "pager-active"
    $(this).addClass "pager-active"
    false
  $(".thumbs a:first").addClass "pager-active"

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

  # Add TinyMCE on desktop
  if $(window).width() > 768
    $('.markdown-help').hide()
    $('textarea').tinymce
      theme: 'advanced'
      theme_advanced_toolbar_location: 'top'
      theme_advanced_buttons1: 'undo,redo,separator,bold,italic,underline,separator,bullist,numlist,outdent,indent,separator,link,unlink'
      theme_advanced_buttons2: ''
      theme_advanced_buttons3: ''
      plugins: 'paste'
      paste_text_sticky: true
      setup: (ed) ->
        ed.onInit.add (ed) ->
          ed.pasteAsPlainText = true
      valid_elements: "
        a[href|title],
        #p,strong/b,em/i,strike,u,-sub,-sup,
        -ol[type|compact],-ul[type|compact],-li,
        -blockquote,caption,-div,-span,
        -code,-pre,samp,tt,var,address,
        -h1,-h2,-h3,-h4,-h5,-h6,hr,br,
        dd,dl,dt,cite,abbr,acronym,dfn,q[cite]"

  # Before submitting, strip the number formatting added by autoNumeric
  $('form#new_listing, form.edit_listing').submit ->
    $('.submit input').addClass('disabled-button')
    $('.submit').append("<div class='wait-text'> Uploading listing... </div>")
    input = $(this).find('input.currency')
    input.val input.val().replace(',','')
