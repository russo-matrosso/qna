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

    this.bind()

  bind: () ->
    that = this

    this.$el.on 'click', 'a.delete_answer', (e) ->
      e.preventDefault()
      console.log('asdfsdf')
      that.$el.hide()
