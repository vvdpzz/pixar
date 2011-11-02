class Pixar.Models.Answer extends Backbone.Model
  paramRoot: 'answer'
  url: "/answers"

  
class Pixar.Collections.AnswersCollection extends Backbone.Collection
  model: Pixar.Models.Answer
  initialize: (a, question) ->
    @url = '/questions/' + question.id + '/answers'