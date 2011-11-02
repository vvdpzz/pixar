Pixar.Views.Messages ||= {}

class Pixar.Views.Messages.ShowView extends Backbone.View
  template: JST["backbone/templates/messages/show"]
  id: "page-container"
    
  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @messages = @options.messages
    @messages.bind('reset', @addAll)
 
  addAll: ->
    @messages.each(@addOne)
  
  addOne: (message) ->
    view = new Pixar.Views.Messages.MessageView({model : message})
    @$('#messages-container').append(view.render().el)
       
  render: ->
    $(@el).html(@template(messages: @messages.toJSON() ))
    @addAll()
    
    return this