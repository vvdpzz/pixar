Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.QuestionView extends Backbone.View
  template: JST["backbone/templates/questions/question"]
  
  events:
    "click .destroy" : "destroy"
      
  tagName: "tr"
  
  destroy: () ->
    @model.destroy()
    this.remove()
    
    return false
    
  render: ->
    $(this.el).html(@template(@model.toJSON() ))    
    return this