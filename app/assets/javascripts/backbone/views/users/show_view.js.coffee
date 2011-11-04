Pixar.Views.Users ||= {}

class Pixar.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]
  
  initialize: (a) ->
    _.bindAll(this, 'render','load_main')
    @user ||= new Pixar.Models.User({}, {uid: a.uid})
  
  render: ->
    that = this
    if @user.id
      @$(this.el).html(@template(@user.toJSON()))
    else
      @user.fetch
        success: (user) ->
          that.load_main()
          
    return this

  load_main: ->
    @$(this.el).html(@template(@user.toJSON()))
    console.log @$(this.el)
