Pixar.Views.Messages ||= {}

class Pixar.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]
  id: "message-entry-proto"
  className: "message-entry clearfix"

  initialize: ()->
    _.bindAll(this, 'render', 'set')
    @model = @options.model
    
  set: ->
    @$('.message-entry:visible').first().addClass('message-first-entry');
    @$('.message-reply-box').show();
  
  render: ->
    $(@el).html(@template(message: @options.model.toJSON() ))
    @set()
    return this