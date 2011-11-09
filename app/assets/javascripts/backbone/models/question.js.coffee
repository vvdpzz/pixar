class App.Models.Question extends Backbone.Model
  paramRoot: 'question'
  
  initialize: ->
    @set
      credit: parseInt(@get('credit'))
      customized_rule: "<div></div>"
  url: ->
    if @isNew() 
      "/questions"
    else
      "/questions/#{@id}"
  