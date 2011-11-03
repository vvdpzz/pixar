class Pixar.Models.Message extends Backbone.Model

  defaults:
    owner_picture: null
    text: null
    owner_profile_url: null
    time_created: null
    owner_name: null
  
class Pixar.Collections.MessageCollection extends Backbone.Collection
  model: Pixar.Models.Message
  url: '/messages/load_messages'