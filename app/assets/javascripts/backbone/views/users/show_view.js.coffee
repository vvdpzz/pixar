Pixar.Views.Users ||= {}

class Pixar.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]
  
  initialize: (a) ->
    @user ||= new Pixar.Models.User({}, {uid: a.uid})
  
  render: ->
    if @user.id
      $(this.el).html(@template(@user.toJSON()))
    else
      @user.fetch
        success: (user) ->
          $(this.el).html(@template(user))
    return this