class App.Routers.Pixar extends Backbone.Router
  routes:
    "!/index"     : "index"
    "!/new"       : "newQuestion"
    "!/:id"       : "show"
    "!/users/:id" : "profile"
    ".*"        : "index"

    
  initialize: ->
    Backbone.history.start() 
    
  index: ->
  newQuestion: ->
  show: (id) ->
  profile: (id) ->
    
     