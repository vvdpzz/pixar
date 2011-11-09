class App.Views.Show extends Backbone.View
  id: "page-node-show"
  template: JST["backbone/templates/questions/show"]
  bottom_shadow_template: '<div class="question-bottom-shadow"></div>'
  initialize: (options)->
    _.bindAll(this, 'render', 'loadMain')
    @question = new App.Models.Question({id: options.qid})
    @answers = new App.Collections.Answers([],{id: options.qid})
  
  render: ->
    $(@el).html(@template)
    @loadMain()
    return this
   
  loadMain: ->
    @question_detail = new App.Views.QuestionDetail({model: @question})
    if @question.length
      @$("#main-content").append(@question_detail.render().el).append(@bottom_shadow_template)
    else
      that = this
      @question.fetch
        success: =>
          that.$("#main-content").append(@question_detail.render().el).append(@bottom_shadow_template)
    

