class Pixar.Models.Question extends Backbone.Model
  paramRoot: 'question'

  defaults:
    title: null
    content: null
    rules_list: null
    customized_rule: null
    credit: null
    reputation: null
    is_blind: null
    is_community: null
  
class Pixar.Collections.QuestionsCollection extends Backbone.Collection
  model: Pixar.Models.Question
  url: '/questions'