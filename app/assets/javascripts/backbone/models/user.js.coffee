class App.Models.User extends Backbone.Model
  initialize: (model, options) ->
    @url = "/users/#{options.id}"
    

