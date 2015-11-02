this.Qna = {}

class @Question
  constructor: () ->
    this.$el = $('.question')
    # this.$answers = $('.answers')
    this.answers = []

$ ->
  Qna.question = new Question

  $(".answers .answer").each((i, e) ->
    console.log(e.id)
    answer = new Answer(e.id)

    Qna.question.answers.push(answer)
  )


























# ready =  ->

#   $('#delete_question').click (e) ->
#     e.preventDefault()
#     $('#delete_confirmation').show();

#   $('#hide_confirmation').click (e) ->
#     e.preventDefault()
#     $('#delete_confirmation').hide();

#   $('form#new_answer').bind 'ajax:success', (e, data, status, xhr) ->
#     response = $.parseJSON(xhr.responseText);
#     console.log(response)
#     $('.answers').append(HandlebarsTemplates['answer'](response))
#     $('form#new_answer > textarea').val('')
#     $('a.delete_answer').click (e)->
#         e.preventDefault()
#         console.log('asdfsdf')
#         $(this).parents('div.answer').hide()

#   $('form#new_answer').bind 'ajax:error', (event, jqxhr, settings, thrownError) ->
#     console.log(jqxhr.responseText)
#     $('form#new_answer').after(jqxhr.responseText)

#   $.getJSON window.location.pathname, (data) ->
#     $.each data, (key) ->
#       console.log(data[key])
#       $('.answers').append(HandlebarsTemplates['answer'](data[key]))

#       $('a.delete_answer').click (e)->
#         e.preventDefault()
#         console.log('asdfsdf')
#         $(this).parents('div.answer').hide()

#       $('form.edit_answer').bind 'ajax:success', (e, data, status, xhr) ->
#         console.log('EDTIT ANSWEr')
#         response = $.parseJSON(xhr.responseText);
#         console.log(response)
#         $(this).parents('div.answer').replaceWith(HandlebarsTemplates['answer'](response))

#       $('.show_edit_answer').click (e) ->
#         e.preventDefault()
#         $(this).parents('div.answer').find('form').show()
#         $(this).parents('div.answer').find('.hide_edit_answer').show()
#         $(this).hide()

#       $('.hide_edit_answer').click (e) ->
#         e.preventDefault()
#         $(this).parents('div.answer').find('form').hide()
#         $(this).parents('div.answer').find('.show_edit_answer').show()
#         $(this).hide()







# $(document).ready(ready)
# $(document).on('page:load', ready)
