class App.Views.Show extends Backbone.View
  id: "page-node-show"
  template: JST["backbone/templates/questions/show"]
  initialize: (options)->
    _.bindAll(this, 'render', 'loadMain')
    alert options
    @question = new App.Models.Question({id: options.qid})
    @answers = new App.Collections.Answers([],{id: options.qid})
  
  render: ->
    $(@el).html(@template)
    return this
   
  loadMain: ->
    if @question.length
      @