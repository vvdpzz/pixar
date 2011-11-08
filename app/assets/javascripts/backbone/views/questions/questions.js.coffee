class App.Views.Questions extends Backbone.View
  tagName: 'ul'
  className: "questions"
  item_template: JST["backbone/templates/questions/question_item"]
  
  initialize: ->
    _.bindAll(this, 'render', 'addOne', 'addAll')
    
  render: ->
    @addAll()
    return this 
    
  addOne: (question) ->
    $(@el).append(@item_template(question.toJSON()))
  
  addAll: ->
    @collection.each(@addOne)

  