class Pixar.Routers.QuestionsRouter extends Backbone.Router
  initialize: (options) ->
    @questions = new Pixar.Collections.QuestionsCollection()
    @questions.reset options.questions

  routes:
    "/new"      : "newQuestion"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newQuestion: ->
    @view = new Pixar.Views.Questions.NewView(collection: @questions)
    $("#questions").html(@view.render().el)

  index: ->
    @view = new Pixar.Views.Questions.IndexView(questions: @questions)
    $("#questions").html(@view.render().el)

  show: (id) ->
    question = @questions.get(id)
    
    @view = new Pixar.Views.Questions.ShowView(model: question)
    $("#questions").html(@view.render().el)
    
  edit: (id) ->
    question = @questions.get(id)

    @view = new Pixar.Views.Questions.EditView(model: question)
    $("#questions").html(@view.render().el)
  