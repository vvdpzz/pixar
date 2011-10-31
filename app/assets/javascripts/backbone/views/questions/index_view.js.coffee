Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.IndexView extends Backbone.View
  template: JST["backbone/templates/questions/index"]
  tagName: "ul"
  id: "questions"
  className: "questions"
    
  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    
    @options.questions.bind('reset', @addAll)
   
  addAll: () ->
    @options.questions.each(@addOne)
  
  addOne: (question) ->
    view = new Pixar.Views.Questions.QuestionView({model : question})
    @$(@el).append(view.render().el)
       
  render: ->
    $(@el).html(@template(questions: @options.questions.toJSON() ))
    @addAll()
    
    return this