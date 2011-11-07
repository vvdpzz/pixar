Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.ShowView extends Backbone.View
  template: JST["backbone/templates/questions/show"]
  
  className: "question"
  
  events:
    "click #answer_button" : "enterSubmission"
  
  initialize: () ->
    _.bindAll(this, 'render', 'initButtons', 'initDialogs', "load_answers")
    @answerCollection = new Pixar.Collections.AnswersCollection([], {id: @model.id})
    self = this
    @answerCollection.fetch
      success: =>
        self.load_answers()
  
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    this.initButtons()
    this.initDialogs()
    return this
  
  load_answers: ->
    answersView = new Pixar.Views.Answers.answersView(collection: @answerCollection)
    $(this.el).append(answersView.render().el)
    $("#answers:last").class+=""
  
  enterSubmission: ->
    @dialog.dialog('open')
    new nicEditor(buttonList: [ "bold", "italic", "underline", "strikethrough", "ol", "ul", "hr" ]).panelInstance("content")
    $('#dlg_new_answer_error').html("").hide()

  initButtons: ->
    @$("#answer_button").button()
  
  initDialogs: ->
    self = this
    newAnswerDialog =
      autoOpen: false
      modal: true
      width: 568
      height: "auto"
      resizable: false
      title: "你的答案"
      dialogClass: "no-opacity-disabled"
      buttons:
        '取消': ->
          self.dialog.dialog "close"
        '提交': ->
          answer = new Pixar.Models.Answer({
            question_id: self.model.id,
            content: $('#new-answer').find('.nicEdit-main').html()
          })
          
          self.answerCollection.create(answer.toJSON(),
            success: (answer) =>
              $('#new-answer').find('.nicEdit-main').html("")
              self.dialog.dialog "close"
            error: (answer, jqXHR) =>
              alert "error"
          )
      open: ->
        $(".ui-dialog-buttonpane :tabbable").blur().removeClass "ui-state-focus"
        content = $("#content").val()
        content = ""  unless content
      close: ->
    @dialog = @$("#dlg_new_answer")
    @dialog.dialog(newAnswerDialog)