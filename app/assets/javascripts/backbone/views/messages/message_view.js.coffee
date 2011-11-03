Pixar.Views.Messages ||= {}

class Pixar.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]
  id: "message-entry-proto"
  className: "message-entry clearfix"

  initialize: ()->
    _.bindAll(this, 'render', 'set')
    @model = @options.model
    
  set: ->
  
  render: ->
    $(@el).html(@template(message: @options.model.toJSON() ))
    @set()
    return this