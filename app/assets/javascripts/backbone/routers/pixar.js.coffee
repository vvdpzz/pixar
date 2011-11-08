class App.Routers.Pixar extends Backbone.Router
  routes:
    ""            : "index"
    "!/new"       : "newQuestion"
    "!/:id"       : "show"
    "!/users/:id" : "profile"
    "!/messages"  : "messages"
    ".*"          : "index"

    
  initialize: ->
    Backbone.history.start() 
    
  index: ->
    @view = new App.Views.Index
    $("#page-container").html(@view.render().el)
  newQuestion: ->
    @view = new App.Views.New
    $("#page-container").html(@view.render().el)

  show: (id) ->
    @view = new App.View.show
    $("#page-container").html(@view.render().el)
  profile: (id) ->
    
  messages: ->
    
     