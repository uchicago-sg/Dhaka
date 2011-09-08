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
      <h2>Syntax Cheatsheet:</h2> 
 
      <h3>Phrase Emphasis</h3> 
 
      <pre><code>*italic*   **bold**
      _italic_   __bold__
      </code></pre> 
 
      <h3>Links</h3> 
 
      <p>Inline:</p> 
 
      <pre><code>An [example](http://url.com/ "Title")
      </code></pre> 
 
      <p>Reference-style labels (titles are optional):</p> 
 
      <pre><code>An [example][id]. Then, anywhere
      else in the doc, define the link:
 
        [id]: http://example.com/  "Title"
      </code></pre> 
 
      <h3>Images</h3> 
 
      <p>Inline (titles are optional):</p> 
 
      <pre><code>![alt text](/path/img.jpg "Title")
      </code></pre> 
 
      <p>Reference-style:</p> 
 
      <pre><code>![alt text][id]
 
      [id]: /url/to/img.jpg "Title"
      </code></pre> 
 
      <h3>Headers</h3> 
 
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
 
      <h3>Lists</h3> 
 
      <p>Ordered, without paragraphs:</p> 
 
      <pre><code>1.  Foo
      2.  Bar
      </code></pre> 
 
      <p>Unordered, with paragraphs:</p> 
 
      <pre><code>*   A list item.
 
          With multiple paragraphs.
 
      *   Bar
      </code></pre> 
 
      <p>You can nest them:</p> 
 
      <pre><code>*   Abacus
          * answer
      *   Bubbles
          1.  bunk
          2.  bupkis
              * BELITTLER
          3. burper
      *   Cunning
      </code></pre> 
 
      <h3>Blockquotes</h3> 
 
      <pre><code>&gt; Email-style angle brackets
      &gt; are used for blockquotes.
 
      &gt; &gt; And, they can be nested.
 
      &gt; #### Headers in blockquotes
      &gt; 
      &gt; * You can quote a list.
      &gt; * Etc.
      </code></pre> 
 
      <h3>Code Spans</h3> 
 
      <pre><code>`&lt;code&gt;` spans are delimited
      by backticks.
 
      You can include literal backticks
      like `` `this` ``.
      </code></pre> 
 
      <h3>Preformatted Code Blocks</h3> 
 
      <p>Indent every line of a code block by at least 4 spaces or 1 tab.</p> 
 
      <pre><code>This is a normal paragraph.
 
          This is a preformatted
          code block.
      </code></pre> 
 
      <h3>Horizontal Rules</h3> 
 
      <p>Three or more dashes or asterisks:</p> 
 
      <pre><code>---
 
      * * *
 
      - - - - 
      </code></pre> 
 
      <h3>Manual Line Breaks</h3> 
 
      <p>End a line with two or more spaces:</p> 
 
      <pre><code>Roses are red,   
      Violets are blue.
      </code></pre> 
      </div>'
    $('.image-upload').hide()
    $('.image-upload').first().show()
    $('#add-image a').click ->
      $('.image-upload:visible').last().next().show()
      if $('.image-upload').size() is $('.image-upload:visible').size() then $(this).remove()
      false
