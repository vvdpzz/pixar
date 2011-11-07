Pixar.Views.Messages ||= {}

class Pixar.Views.Messages.ShowView extends Backbone.View
  template: JST["backbone/templates/messages/show"]
  id: "page-container"
  
  events:
    "keyup .message-reply-box textarea" : "updateReplyMessageCountdown"
    "blur .message-reply-box textarea" : "updateReplyMessageCountdown"
    "click #btn-reply-message" : "replyMessage"
    "click #btn-back-to-conversations" : "redirect"
    
  initialize: ->
    _.bindAll(this, 'addOne', 'addAll', 'render', 'initMessagesView')
    @messages = @options.messages
    @messages.bind('reset', @addAll)
    @friend_token = @options.friend_token
    @messageTextLimit = 1000
    @isReplyBoxBeFixed = false
 
  addAll: ->  
    @messages.each(@addOne)
  
  addOne: (message) ->
    view = new Pixar.Views.Messages.MessageView({model : message})
    @$('#messages-container').append(view.render().el)
    
  initMessagesView: ->
    @$('.message-reply-box').show()
    @$('#reply-message-countdown').text(@messageTextLimit)
  
  updateReplyMessageCountdown: ->  
    countdown = @messageTextLimit - $('.message-reply-box textarea').val().length
    $('#reply-message-countdown').text(countdown)
    if countdown < 0
      $('#reply-message-countdown').addClass('negative')
    else
      $('#reply-message-countdown').removeClass('negative')
    @updateReplyButtonState()
    
  updateReplyButtonState: ->
    msg = $('.message-reply-box textarea').val()
    if msg.length > 0 and msg.length <= @messageTextLimit
      $('#btn-reply-message').removeClass('btn-disabled')
    else
      $('#btn-reply-message').addClass('btn-disabled')
  
  replyMessage: ->
    if $('#btn-reply-message').hasClass('btn-disabled')
      return
    $('#btn-reply-message').addClass('btn-disabled');
    messageText = $('.message-reply-box textarea').val()
    $.post(
      "/messages/send_message.json",
      { recipient_token: @friend_token, text: messageText },
      (data)=>  
        if (data.rc)
          # ce6.notifyBar(data.msg, 'error');
          $('#btn-reply-message').removeClass('btn-disabled')
        else 
          @showNewMessage(data.outgoing_token, htmlEscape(messageText))
          scrollToBottom()
          $('.message-reply-box textarea').val('')
          $('#reply-message-countdown').text(@messageTextLimit)
    )
  
  showNewMessage: (messageToken, messageText)->
    message = {
      message_token : messageToken,
      owner_name : viewer.name,
      owner_picture : viewer.picture,
      owner_profile_url : '',
      time_created : '1 second ago',
      text : messageText
    }
    e = @constructMessageEntry(message)
    @messages.add(message)
    e.appendTo('#messages-container')
    # background animation 
    e.append($("<div>")
      .css({
        backgroundColor: '#fee791',
        position: 'absolute',
        top: 0,
        left: 0,
        zIndex: -1,
        width: e.outerWidth(),
        height: e.outerHeight()
      })
      .addClass('entry-background')
    )
    e.find('.entry-background').fadeOut(1000,
      =>
        e.find('.entry-background').remove()
    )
    
  constructMessageEntry: (data)->
    box = $('#message-entry-proto').clone().show().attr('id', 'message-entry-' + data.message_token)
    box.find('.friend-picture a').attr('href', data.owner_profile_url)
    box.find('.friend-picture img').attr('src', data.owner_picture)
    box.find('.message-info .owner-name').html(data.owner_name).attr('href', data.owner_profile_url)
    box.find('.message-info .message-date').html(data.time_created)
    box.find('.message-body').html(data.text)
    return box
  
  redirect: ->
    window.location.hash = "#/messages/conversations"
    false
       
  render: ->
    $(@el).html(@template(messages: @messages.toJSON() ))
    @addAll()
    @initMessagesView()
    return this