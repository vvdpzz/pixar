class App.Models.Question extends Bacbone.Model
  url: ->
     "/questions/#{@.id}"
