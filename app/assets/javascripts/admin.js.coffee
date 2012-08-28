$(document).ready ->
  $('.admin-role').delegate 'a.admin', 'ajax:success', ->
    $.sticky 'Successfully updated permissions'
    $(this).text ->
      return if $(this).text() is 'Revoke Admin Rights' then 'Grant Admin Rights' else 'Revoke Admin Rights'

  $('.seller-role').delegate 'a.seller', 'ajax:success', ->
    $.sticky 'Successfully updated permissions'
    $(this).text ->
      return if $(this).text() is 'Revoke Seller Rights' then 'Grant Seller Rights' else 'Revoke Seller Rights'

  $('.lock-user').delegate 'a.lock', 'ajax:success', ->
    $.sticky 'Successfully toggled lock'
    $(this).text ->
      return if $(this).text() is 'Unlock Account' then 'Lock Account' else 'Unlock Account'

  $('.confirm-user').delegate 'a.confirm', 'ajax:success', ->
    $.sticky 'Successfully confirmed user'
    $(this).closest('.user').slideUp().remove()
    if $('.user').size() is 0 then $('#main').html('<h2 class="sorry">No pending confirmations</h2>')