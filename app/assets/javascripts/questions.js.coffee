ready =  ->

  $('#delete_question').click (e) ->
    e.preventDefault()
    $('#delete_confirmation').show();

  $('#hide_confirmation').click (e) ->
    e.preventDefault()
    $('#delete_confirmation').hide();

  $('form#new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText);
    console.log(response)
    $('.answers').after(HandlebarsTemplates['answer'](response))
    $('form#new_answer > textarea').val('')
    $('a.delete_answer').click (e)->
        e.preventDefault()
        console.log('asdfsdf')
        $(this).parents('div.answer').hide()

  $.getJSON window.location.pathname, (data) ->
    $.each data, (key) ->
      console.log(data[key])
      $('.answers').append(HandlebarsTemplates['answer'](data[key]))

      $('a.delete_answer').click (e)->
        e.preventDefault()
        console.log('asdfsdf')
        $(this).parents('div.answer').hide()

      $('form.edit_answer').bind 'ajax:success', (e, data, status, xhr) ->
        console.log('EDTIT ANSWEr')
        response = $.parseJSON(xhr.responseText);
        console.log(response)
        $(this).parents('div.answer').replaceWith(HandlebarsTemplates['answer'](response))







$(document).ready(ready)
$(document).on('page:load', ready)
