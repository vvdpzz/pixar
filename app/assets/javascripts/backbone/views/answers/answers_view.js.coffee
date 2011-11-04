Pixar.Views.Answers ||= {}

class Pixar.Views.Answers.answersView extends Backbone.View
  tagName: "div"
  id: "answers"

  initialize: () ->
    _.bindAll(this, 'addOne', 'addAll', 'render')
    @collection = @options.collection
    @collection.bind('add', this.addOne, this)
    
  addOne: (answer) ->
    view = new Pixar.Views.Answers.answerView({model: answer})
    @$(@el).prepend(view.render().el)

  addAll: ->
    @collection.each(@addOne)

  render: ->
    this.addAll()
    return this