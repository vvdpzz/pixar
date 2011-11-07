class App.Collections.Answers extends Bacbone.Collection
  model: App.Models.Answer
  initialize: (models, options) ->
    @url = "/questions/#{options.qid}/answers"
