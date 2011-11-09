class App.Routers.Pixar extends Backbone.Router
  routes:
    "!/"          : "index"
    "!/new"       : "newQuestion"
    "!/:id"       : "show"
    "!/users/:id" : "profile"
    "!/messages/" : "messages"
    ".*"          : "index"

    
  initialize: ->
    Backbone.history.start() 
    
  index: ->
    @view = new App.Views.Index
    $("#top_nav li").removeClass('active')
    $("#top_nav li:first-child").addClass('active')
    $("#page-container").html(@view.render().el)
  newQuestion: ->
    @view = new App.Views.New
    $("#top_nav li").removeClass('active')
    $("#top_nav li:last-child").addClass('active')
    $("#page-container").html(@view.render().el)

  show: (id) ->
    @view = new App.Views.Show({qid: id})
    $("#page-container").html(@view.render().el)
  profile: (id) ->
    $("#top_nav li").removeClass('active')
    $("#top_nav li:nth-child(2)").addClass('active')
  messages: ->
    @view = new App.Views.Message
    $("#page-container").html(@view.render().el)
     
