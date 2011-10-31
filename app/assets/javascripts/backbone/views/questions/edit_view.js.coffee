Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.EditView extends Backbone.View
  template : JST["backbone/templates/questions/edit"]
  
  events :
    "submit #edit-question" : "update"
    
  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @model.save(null,
      success : (question) =>
        @model = question
        window.location.hash = "/#{@model.id}"
      error : (question, response) =>
        alert "error"
        alert JSON.stringify question
        alert JSON.stringify response
    )
    
  render : ->
    $(this.el).html(this.template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    
    return this