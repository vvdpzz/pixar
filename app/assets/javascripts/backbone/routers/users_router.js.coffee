class Pixar.Routers.UsersRouter extends Backbone.Router
  initialize: (options) ->
    @users = new Pixar.Collections.UsersCollection()
    @users.reset options.users

  routes:
    "/new"      : "newUser"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newUser: ->
    @view = new Pixar.Views.Users.NewView(collection: @users)
    $("#users").html(@view.render().el)

  index: ->
    @view = new Pixar.Views.Users.IndexView(users: @users)
    $("#users").html(@view.render().el)

  show: (id) ->
    user = @users.get(id)
    
    @view = new Pixar.Views.Users.ShowView(model: user)
    $("#users").html(@view.render().el)
    
  edit: (id) ->
    user = @users.get(id)

    @view = new Pixar.Views.Users.EditView(model: user)
    $("#users").html(@view.render().el)
  