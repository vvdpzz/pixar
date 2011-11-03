class Pixar.Routers.MessagesRouter extends Backbone.Router
  initialize: () ->
    @conversations = new Pixar.Collections.ConversationCollection()
    @messages = @messages || {}
    self = this

  routes:
    "/messages/conversations" : "conversations"
    "/messages/messages/:id"  : "messages"
    
  conversations: ->
    if @conversations.length == 0
      @conversations.fetch
        success: =>
          @conversations.each (conversation) =>
            @messages[conversation.get("friend_token")] = new Pixar.Collections.MessageCollection(conversation.get("messages"))
            conversation.unset("messages")
          @view = new Pixar.Views.Messages.IndexView(conversations : @conversations)
          $("#page-layout").html(@view.render().el) 
    @view = new Pixar.Views.Messages.IndexView(conversations : @conversations)
    $("#page-layout").html(@view.render().el)
    
  messages: (id)->
    if @messages[id]
      @view = new Pixar.Views.Messages.ShowView({messages : @messages[id], friend_token : id})
      $("#page-layout").html(@view.render().el)
      @initMessage()
    else
      @conversations.fetch
        success: =>
          @conversations.each (conversation) =>
            @messages[conversation.get("friend_token")] = new Pixar.Collections.MessageCollection(conversation.get("messages"))
            conversation.unset("messages")   
          @view = new Pixar.Views.Messages.ShowView({messages : @messages[id], friend_token : id})
          $("#page-layout").html(@view.render().el)
          @initMessage()
  
  initMessage: ->
    # first message style
    $('.message-entry:visible').first().addClass('message-first-entry')
    # init message box
    $(window).resize(@replyBoxPosition)
    $(window).scroll(@showBorderShadow)
    @replyBoxPosition()
    @scrollToBottom()
     
  replyBoxPosition: ->
    replyBoxTop = $('#messages-container').offset().top + $('#messages-container').innerHeight()
    replyBoxHeight = $('.message-reply-box').outerHeight()
    replyBoxBottom = replyBoxTop + replyBoxHeight
    willReplyBoxBeFixed = (replyBoxBottom > $(window).height())
    if willReplyBoxBeFixed != @isReplyBoxBeFixed
      if willReplyBoxBeFixed
        $('.message-reply-box').css({
          'position' : 'fixed',
          'bottom' : 0
        })
        $('#messages-container').css('margin-bottom', replyBoxHeight)
        borderPos = $('.message-header-fixed').offset().top + $('.message-header-fixed').innerHeight()
        $('.message-border-shadow').css('top', borderPos)
        @showBorderShadow()
      else
        $('.message-reply-box').css({
          'position' : 'static'
        })
        $('#messages-container').css('margin-bottom', 0)
    @isReplyBoxBeFixed = willReplyBoxBeFixed

  showBorderShadow: ->
    if $(window).scrollTop() > 0
      $('.message-border-shadow').show()
    else
      $('.message-border-shadow').hide()

  scrollToBottom: ->
    $(window).scrollTop($(document).height())
    
    