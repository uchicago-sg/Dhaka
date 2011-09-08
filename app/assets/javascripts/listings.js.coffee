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

  # Limit the price input
  $('.currency').autoNumeric()
  
  # Hide image upload inputs, and allow the user to reveal them
  if $('#listings.new').exists() or $('#listings.edit').exists()
    # Markdown help
    $('a#markdown').fancybox
      content: '
      <div class="syntax-cheatsheet">
      <h1>Syntax Cheatsheet:</h1> 
 
      <h2>Phrase Emphasis</h2> 
 
      <pre><code>*italic*   **bold**
      _italic_   __bold__
      </code></pre> 
 
      <h2>Links</h2> 
 
      <pre><code>An [example](http://url.com/ "Title")
      </code></pre> 

      <h2>Headers</h2> 
 
      <p>Setext-style:</p> 
 
      <pre><code>Header 1
      ========
 
      Header 2
      --------
      </code></pre> 
 
      <p>atx-style (closing #s are optional):</p> 
 
      <pre><code># Header 1 #
 
      ## Header 2 ##
 
      ###### Header 6
      </code></pre> 
 
      <h2>Lists</h2> 
 
      <p>Ordered, without paragraphs:</p> 
 
      <pre><code>1.  Foo
      2.  Bar
      </code></pre> 
 
      <p>Unordered, with paragraphs:</p> 
 
      <pre><code>*   A list item.
 
          With multiple paragraphs.
 
      *   Bar
      </code></pre> 
 
 
      <h2>Blockquotes</h2> 
 
      <pre><code>
      &gt; Email-style angle brackets
      &gt; are used for blockquotes.
 
      &gt; &gt; And, they can be nested.
 
      &gt; #### Headers in blockquotes
      &gt; 
      &gt; * You can quote a list.
      &gt; * Etc.
      </code></pre> 
 
      </div>'
    $('.image-upload').hide()
    $('.image-upload').first().show()
    $('#add-image a').click ->
      $('.image-upload:visible').last().next().show()
      if $('.image-upload').size() is $('.image-upload:visible').size() then $(this).remove()
      false
