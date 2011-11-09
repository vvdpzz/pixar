class App.Views.QuestionDetail extends Backbone.View
  className: "question-detail"
  item_template: JST["backbone/templates/questions/question_detail"]
  
  initialize: ->
    _.bindAll(this, 'render')
    
  render: ->
    $(@el).html(@item_template(@model.toJSON()))
    return this 


  
