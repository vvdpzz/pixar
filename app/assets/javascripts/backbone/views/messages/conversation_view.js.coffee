Pixar.Views.Messages ||= {}

class Pixar.Views.Messages.ConversationView extends Backbone.View
  template: JST["backbone/templates/messages/conversation"]
  id: "conversation-box-proto"
  className: "conversation-box"
  
  events:
    "click .conversation-box" : "redirect"

  initialize: ()->
    _.bindAll(this, 'setBind', 'render')
    @model = @options.model
    
  setBind: ->  
    if @model.get('last_message_is_outgoing')
      $(@el).find('.conversation-info .message-preview').addClass('outgoing-icon')
    if @model.get('unread_message_count') > 0
      $(@el).addClass('conversation-box-highlight');
      friendName = @model.get('friend_name') + ' (' + @model.get('unread_message_count') + ')';
      $(@el).find('.conversation-info .friend-name').html(friendName);
    $(@el).attr("id", 'conversation-box-'+@model.get('friend_token'))
  
  render: ->
    $(@el).html(@template(conversation: @options.model.toJSON() ))
    @setBind()
    return this
  
  redirect: ->
    window.location.href = "#/messages/messages/" + @model.get('friend_token')