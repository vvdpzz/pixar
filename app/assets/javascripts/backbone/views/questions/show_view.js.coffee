Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.ShowView extends Backbone.View
  template: JST["backbone/templates/questions/show"]
  
  events:
    "click #answer_button" : "enterSubmission"
  
  initialize: () ->
    _.bindAll(this, 'render', 'initButtons', 'initDialogs')
  
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
  
    this.initButtons()
    this.initDialogs()
  
    return this
  
  enterSubmission: ->
    $('#dlg_new_answer').dialog('open')
    new nicEditor(buttonList: [ "bold", "italic", "underline", "strikethrough", "ol", "ul", "hr" ]).panelInstance("content")
    $('#dlg_new_answer_error').html("").hide()

  initButtons: ->
    @$("#answer_button").button()
  
  initDialogs: ->
    newAnswerDialog =
      autoOpen: false
      modal: true
      width: 568
      height: "auto"
      resizable: false
      title: "Your answer"
      dialogClass: "no-opacity-disabled"
      buttons:
        Discard: ->
          $(this).dialog "close"
        Submit: ->
          alert "ok"
      open: ->
        $(".ui-dialog-buttonpane :tabbable").blur().removeClass "ui-state-focus"
        content = $("#content").val()
        content = ""  unless content
      close: ->
    @$("#dlg_new_answer").dialog(newAnswerDialog)