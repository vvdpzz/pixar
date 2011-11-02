Pixar.Views.Answers ||= {}

class Pixar.Views.Answers.answerView extends Backbone.View
  template : JST["backbone/templates/answers/answer"]
  tagName: "li"
  className: "answer"
  
  initialize: ->
    _.bindAll(this, 'render')
    @$(@el).attr("id", @model.id)
  
  render : ->
    $(this.el).html(this.template(@model.toJSON() ))
    
    return this