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

jQuery.fn.exists = -> jQuery(this).length > 0

$(document).ready ->
  $('#debug').click -> $(this).fadeOut() # Hide mechanism for flashes and debug

  unless $('#listings.show').exists()
    jQuery.timeago.settings.strings =
      prefixAgo: null
      prefixFromNow: null
      suffixAgo: 'ago'
      suffixFromNow: null
      seconds: 'Less than a minute'
      minute: 'About a minute'
      minutes: '%d minutes'
      hour: 'About an hour'
      hours: 'About %d hours'
      day: 'A day'
      days: '%d days'
      month: 'About a month'
      months: '%d months'
      year: 'About a year'
      years: '%d years'
      numbers: []

  $('.time-ago').attr('title', '').timeago()

  # First-time visitor welcome splash
  unless $.cookie('visited')
    $.cookie 'visited', true
    $(document).ready ->
      $.fancybox
        centerOnScroll: true
        content: '
          <div id="splash">
            <h1>Welcome to the Marketplace</h1>
            <h2>Looks like it&#8217;s your first time visiting the beta</h2>
            <p>Take a moment to <a href="/about" title="About Marketplace">read about the new design</a> and remember we are still testing, so you may also want to list items on the <a href="http://marketplace.uchicago.edu/" title="The Marketplace"> current Marketplace</a>. You can leave feedback using the orange button near the bottom-right corner of the page.</p>
          </div>
        '

  # Add search form behavior
  listing_search_form = $('#simple_search')
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
        $(this).removeClass('show-more').addClass('show-less').html('&#171; Less')
      else
        $(this).removeClass('show-less').addClass('show-more').html('More &#187;')

  # Ajaxify "starred" links
  $('td.starred').delegate 'a.star', 'ajax:success', ->
    $(this).removeClass('available')
    $(this).parent().find('a.unstar').addClass('available')
    $.sticky 'Successfully starred listing'

  $('td.starred').delegate 'a.unstar', 'ajax:success', ->
    # Hide the listing when unstarred on listings/starred, otherwise rework the link
    if $('#listings.starred').exists()
      $(this).closest('.listing').slideUp().remove()
      if $('.listing').size() is 0 then $('#main').html('<h2 class="sorry">No results found</h2>')
    else
      $(this).removeClass('available')
      $(this).parent().find('a.star').addClass('available')
    $.sticky 'Successfully unstarred listing'

  $.fn.extend
    addListingLink: ->
      # Reanimate the listing's link
      listing = $(this).closest('.listing')
      desc    = listing.find('.description')
      desc.html "<a href='/#{listing.attr('id')}'>#{desc.text()}</a>"
    removeListingLink: ->
      # Close the listing's link
      listing = $(this).closest('.listing')
      desc    = listing.find('.description')
      desc.html desc.text()

  # Notify of successful renewal and disallow another renewal by removing the link
  $('.renew').bind 'ajax:success', ->
    $.sticky 'Successfully renewed listing'
    $(this).html $(this).find('a').text()
    $(this).addListingLink()

  # Notify of publicize or unpublicize
  $('.publish').closest('.listing').find('.renew').hide()
  $('.publicize').delegate 'a.publish', 'ajax:success', ->
    $.sticky 'Successfully published listing'
    $(this).removeClass('publish').addClass('unpublish').text('Unpublish')
    publish = $(this).attr 'href'
    $(this).attr('href', $(this).attr('data-unpublish')).attr('data-publish', publish)
    $(this).closest('.listing').find('.renew').show()
    $(this).addListingLink()

  $('.publicize').delegate 'a.unpublish', 'ajax:success', ->
    $.sticky 'Successfully unpublished listing'
    $(this).removeClass('unpublish').addClass('publish').text('Publish')
    unpublish = $(this).attr 'href'
    $(this).attr('href', $(this).attr('data-publish')).attr('data-unpublish', unpublish)
    listing = $(this).closest('.listing')
    listing.find('.renew').hide()
    if $('#users.dashboard').exists()
      $(this).removeListingLink()
    else
      listing.slideUp().remove()
      if $('.listing').size() is 0 then $('#main').html('<h2 class="sorry">No results found</h2>')

  # Slick new flashes mechanism with Sticky
  $('.flash').hide().each -> $(this).sticky()

  # Throw in a tip every once in a while
  tips = [
    'Listings with light blue backgrounds were created by signed sellers',
    'Star listings to save them for review later',
    'Subscribe to any Advanced Search to get real-time updates',
    'Visit the <a href="/feeds" title="Atom Feeds">Atom Feeds</a> page to subscribe to categories',
    'Look out for scams. Visit our <a href="/safety" title="Safety & Security">Safety &amp; Security</a> page.',
    'See the <a href="/welcome" title="Welcome Notes">Welcome Notes</a> for more information on the new design'
  ]

  a = Math.random() * 1000
  b = Math.random() * 75
  c = Math.floor((a + b) % tips.length)
  if a < b then $.sticky('<strong>Tip:</strong> ' + tips[c])


  # Submit the search form again when user interacts with "View" or "Sort by" selects
  $('#meta_mode').change ->
    $('#mode').val $(this).val()
    $('#simple_search').submit()

  $('#meta_order').change ->
    $('#order').val $(this).val()
    $('#simple_search').submit()