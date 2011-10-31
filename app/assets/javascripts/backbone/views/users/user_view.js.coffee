Pixar.Views.Users ||= {}

class Pixar.Views.Users.UserView extends Backbone.View
  template: JST["backbone/templates/users/user"]
  
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