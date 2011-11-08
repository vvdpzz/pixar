class App.Views.Index extends Backbone.View
  el: '#containter'
  template: JST["backbone/templates/questions/index"]
  initialize: ->
    _.bindAll(this, 'render', 'loadMain')
    @questins = new App.Collections.Questions
  
  render: ->
    if @questins.length 
      @loadMain()
    else
      that = this
      @questins.fetch
        success: =>
          that.loadMain()
   
  loadMain: ->
    @questionsView = new App.Views.Questions({collection: @questins})
    @$("#main-content").html(@questionsView.render().el)
  