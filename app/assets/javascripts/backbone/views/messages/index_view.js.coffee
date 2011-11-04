Pixar.Views.Messages ||= {}

class Pixar.Views.Messages.IndexView extends Backbone.View
  template: JST["backbone/templates/messages/index"]
  id: "page-container"
  
  events:
    "click #btn-send-message" : "sendMessageOnConversationView"
    
  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @conversations = @options.conversations
    @conversations.bind('reset', @addAll)
 
  addAll: ->
    @conversations.each(@addOne)
  
  addOne: (conversation) ->
    view = new Pixar.Views.Messages.ConversationView({model : conversation})
    @$('#conversations-container').append(view.render().el)
    
  sendMessageOnConversationView: ->
    pixar.sendMessageOnConversationView()
       
  render: ->
    $(@el).html(@template(conversations: @conversations.toJSON() ))
    if @conversations.length > 0
      @$('#conversations-empty').hide()
      @addAll()
    else  
      @$('#conversations-empty').show()
    
    return this