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
      console.log(that.$body)
      that.$body.text(response.body)
      that.toggle_edit()


  toggle_edit: () ->
    this.$hide_edit_answer.toggle()
    this.$show_edit_answer.toggle()
    this.$form.toggle()








