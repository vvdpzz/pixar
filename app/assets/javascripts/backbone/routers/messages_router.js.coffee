class Pixar.Routers.MessagesRouter extends Backbone.Router
  initialize: () ->
    @conversations = new Pixar.Collections.ConversationCollection()
    @messages = {}
    self = this
    @conversations.fetch
      success: =>
        alert 122
        self.conversations.each (conversation) =>
          self.messages[conversation.get("friend_token")] = new Pixar.Collections.MessageCollection(conversation.get("messages"))
          conversation.unset("messages")

  routes:
    "/messages/conversations" : "conversations"
    "/messages/messages/:id"  : "messages"
    
  conversations: ->
    @view = new Pixar.Views.Messages.IndexView(conversations : @conversations)
    $("#page-layout").html(@view.render().el)
    
  messages: (id)->
    @view = new Pixar.Views.Messages.ShowView(messages : @messages[id])
    $("#page-layout").html(@view.render().el)
    
    