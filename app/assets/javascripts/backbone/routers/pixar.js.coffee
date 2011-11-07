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
    alert "new"
    @view = new App.Views.New()
    $("#main-content").html(@view.render().el)

  show: (id) ->
  profile: (id) ->
    
     