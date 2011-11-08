class App.Views.Message extends Backbone.View
  id: "page-node-message"
  template: JST["backbone/templates/messages/index"]
  initialize: ->
    _.bindAll(this, 'render', 'loadMain')
    @messages = new App.Collections.Message
  
  render: ->
   
  loadMain: ->
