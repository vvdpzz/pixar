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
    alert "index"
  newQuestion: ->
    alert "new"
  show: (id) ->
    alert "show #{id}"
  profile: (id) ->
    alert "prodile #{id}"
    
     