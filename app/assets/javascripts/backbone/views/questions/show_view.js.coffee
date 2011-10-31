Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.ShowView extends Backbone.View
  template: JST["backbone/templates/questions/show"]
   
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    return this