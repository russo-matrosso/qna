# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).toggle()
    $(this).text('Hide') if $('form#edit-answer-' + answer_id).css('display') != 'none'
    $(this).text('Edit') if $('form#edit-answer-' + answer_id).css('display') == 'none'