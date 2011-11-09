class App.Views.Index extends Backbone.View
  id: "page-node-home"
  template: JST["backbone/templates/questions/index"]
  initialize: ->
    _.bindAll(this, 'render', 'loadMain')
    @questions = new App.Collections.Questions
  
  render: ->
    $(@el).html(@template)
    if @questions.length 
      @loadMain()
    else
      that = this
      @questions.fetch
        success: =>
          that.loadMain()
    return this
   
  loadMain: ->
    @questionsView = new App.Views.Questions({collection: @questions})
    @$("#question-content-container").html(@questionsView.render().el)
  