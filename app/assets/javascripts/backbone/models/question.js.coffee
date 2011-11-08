class App.Models.Question extends Backbone.Model
  paramRoot: 'question'
  url: ->
    if @isNew() 
      "/questions"
    else
      "/questions/#{@id}"