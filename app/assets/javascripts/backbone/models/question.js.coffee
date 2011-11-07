class App.Models.Question extends Backbone.Model
  url: ->
     "/questions/#{@.id}"
