ready =  ->

  $('#delete_question').click (e) ->
    e.preventDefault()
    $('#delete_confirmation').show();

  $('#hide_confirmation').click (e) ->
    e.preventDefault()
    $('#delete_confirmation').hide();

  $.getJSON(window.location.pathname, (data) ->
    $.each data, (key) ->
      console.log(data[key])
      $('.answers').append(HandlebarsTemplates['answer'](data[key]))
  )

  $('form#new_answer').bind('ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText);
    console.log(response.object)
    $('.answers').after(HandlebarsTemplates['answer'](response));
    $('form#new_answer > textarea').val('')
  )



$(document).ready(ready)
$(document).on('page:load', ready)
