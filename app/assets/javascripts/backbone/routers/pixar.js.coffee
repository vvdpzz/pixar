class App.Routers.Pixar extends Backbone.Router
  routes:
    ""            : "index"
    "!/new"       : "newQuestion"
    "!/:id"       : "show"
    "!/users/:id" : "profile"
    ".*"        : "index"

    
  initialize: ->
    Backbone.history.start() 
    
  index: ->
    alert "home"
    @view = new App.Views.Index
    $('body').append(@view.render().el)
  newQuestion: ->
    @view = new App.Views.New()
    $("#main-content").html(@view.render().el)

  show: (id) ->
  profile: (id) ->
    
     