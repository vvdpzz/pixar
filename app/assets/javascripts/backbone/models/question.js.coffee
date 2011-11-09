class App.Models.Question extends Backbone.Model
  paramRoot: 'question'
  
  initialize: ->
    unless @isNew() 
      @set
        credit: parseInt(@get('credit'))

  url: ->
    if @isNew() 
      "/questions"
    else
      "/questions/#{@id}"
  
  parse: (response) ->
    @set(response)
    @set
      credit: parseInt(@get('credit'))
      rules: @get_rules()
  
  get_rules: ->
    rules = ""
    rules += "<li>#{RULES[i]}</li>" for i in @get('rules_list').split(',')
    rules