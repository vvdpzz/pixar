Pixar.Views.Questions ||= {}

class Pixar.Views.Questions.NewView extends Backbone.View    
  template: JST["backbone/templates/questions/new"]
  
  events:
    "submit #new-question": "save"
    
  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )
    
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()
      
    @model.unset("errors")
    
    @model.set({content: @$('#new-question').find('.nicEdit-main').html()})
    
    @collection.create(@model.toJSON(), 
      success: (question) =>
        @model = question
        window.location.hash = "/#{@model.id}"
        
      error: (question, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    
    this.$("form").backboneLink(@model)
    
    return this