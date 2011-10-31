Pixar.Views.Users ||= {}

class Pixar.Views.Users.EditView extends Backbone.View
  template : JST["backbone/templates/users/edit"]
  
  events :
    "submit #edit-user" : "update"
    
  update : (e) ->
    e.preventDefault()
    e.stopPropagation()
    
    @model.save(null,
      success : (user) =>
        @model = user
        window.location.hash = "/#{@model.id}"
    )
    
  render : ->
    $(this.el).html(this.template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    
    return this