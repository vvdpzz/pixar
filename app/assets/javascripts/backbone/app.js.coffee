#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./view
#= require_tree ./routers

window.App =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

  initialize: ->
    new App.Routers.Pixar
  
  notifyBar: (msgText, notifyType, speed, position) ->
    msgHtml = "<div class='bar_content'><div class='bar_title'>*notify_type*</div><div class='bar_divider'></div><div class='bar_message'>*msg*</div></div>"
    msgHtml = msgHtml.replace("*msg*", msgText)
    realSpeed = speed or 10000
    showPos = position or "overlay"
    container = undefined
    if showPos is "above"
      container = "#top"
    else if showPos is "below"
      container = "#top_sub"
    else
      container = "body"
    if notifyType
      msgHtml = msgHtml.replace("*notify_type*",notifyType)
      $.notifyBar
        close: true
        cls: notifyType
        html: msgHtml
        speed: realSpeed
        container: container
    else
      $.notifyBar
        close: true
        html: msgHtml
        speed: realSpeed
        container: container