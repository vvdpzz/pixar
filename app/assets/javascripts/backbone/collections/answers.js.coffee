class App.Collections.Answers extends Backbone.Collection
  model: App.Models.Answer
  initialize: (models, options) ->
    @url = "/questions/#{options.qid}/answers"
