class Pixar.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    name: null
    email: null
    credit: null
    reputation: null
    
  initialize: (b, a) ->
    @url = "/users/#{a.uid}"
  
class Pixar.Collections.UsersCollection extends Backbone.Collection
  model: Pixar.Models.User
  url: '/users'