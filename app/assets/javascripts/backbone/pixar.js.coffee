#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Pixar =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  
  initialize: ->
    new Pixar.Routers.MessagesRouter
    
    