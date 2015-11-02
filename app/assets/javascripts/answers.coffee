# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $(document).on('page:load', ->
# #  $('.edit-answer-link').click (e) ->
# #    e.preventDefault()
# #    answer_id = $(this).data('answerId')
# #    $('form#edit-answer-' + answer_id).toggle()
# #
# #
# #  $('.delete-answer-link').click (e) ->
# #    e.preventDefault()
# #    answer_id = $(this).data('answerId')
# #    $('#delete-answer-' + answer_id).toggle()

# ##





# )


class @Answer
  constructor: (answer_id) ->
    this.$el = $("##{answer_id}")
    this.$body = this.$el.find(".answer-body")
    this.$form = this.$el.find("form.edit_answer")
    this.$show_edit_answer = this.$el.find('a.show_edit_answer')
    this.$hide_edit_answer = this.$el.find('a.hide_edit_answer')

    this.bind()
    this.axaj()

  bind: () ->
    that = this

    this.$el.on 'click', 'a.delete_answer', (e) ->
      e.preventDefault()
      that.$el.hide()

    this.$show_edit_answer.click (e) ->
      e.preventDefault()
      that.toggle_edit()

    this.$hide_edit_answer.click (e) ->
      e.preventDefault()
      that.toggle_edit()

  axaj: () ->
    that = this

    this.$form.bind 'ajax:success', (e, data, status, xhr) ->
      response = $.parseJSON(xhr.responseText);
      console.log(response)
      that.$body.text(response.body)
      that.toggle_edit()


  toggle_edit: () ->
    this.$hide_edit_answer.toggle()
    this.$show_edit_answer.toggle()
    this.$form.toggle()








