Pixar.Views.Users ||= {}

class Pixar.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]
  
  initialize: (a) ->
    @user ||= new Pixar.Models.User({}, {uid: a.uid})
    
  
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    return this