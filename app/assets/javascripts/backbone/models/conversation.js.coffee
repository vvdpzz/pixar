class Pixar.Models.Conversation extends Backbone.Model

  defaults:
    unread_message_count: null
    last_message_is_outgoing: null
    last_message: null
    friend_name: null
    friend_token: null
    friend_picture: null
    last_update: null
  
class Pixar.Collections.ConversationCollection extends Backbone.Collection
  model: Pixar.Models.Conversation
  url: '/messages/load_conversations'