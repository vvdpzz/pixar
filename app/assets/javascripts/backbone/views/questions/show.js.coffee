class App.Views.Show extends Backbone.View
  id: "page-node-show"
  template: JST["backbone/templates/questions/show"]
  initialize: ->
    _.bindAll(this, 'render', 'loadMain')
    @question = new App.Models.Question({id: @options.id})
    @answers = new App.Collections.Answers([],{id: @options.id})
  
  render: ->
    return this
   
  loadMain: ->
