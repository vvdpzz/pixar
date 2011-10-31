Pixar.Views.Users ||= {}

class Pixar.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]
   
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    return this