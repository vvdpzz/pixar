class App.Views.New extends Backbone.View
  template: JST["backbone/templates/questions/new"]
  
  events:
    "submit #new-question": "save"
  initialize: () ->
    _.bindAll(this, 'render', 'initEffect')
  
  constructor: (options) ->
    super(options)
    @model = new App.Models.Question()

    @model.bind("change:errors", () =>
      this.render()
    )
    
  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(
      success: (question) =>
        @model = question
        window.location.hash = "/#{@model.id}"
      error: (question, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
    
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    
    this.initEffect()
    
    return this
  
  initEffect: ->
    @datepicker = @$("#date_picker")
    @$("#customized_credit").blur().focus ->
      $("#radio_customized_credit").attr("checked",true)
    
    @$("#radio_customized_credit").change ->
      $("#customized_credit").focus()
    
    @$("#customized_reputation").blur().focus ->
      $("#radio_customized_reputation").attr("checked",true)
    
    @$("#radio_customized_reputation").change ->
      $("#customized_reputation").focus()
    
    @$("#rules_0").change ->
      if $(this).attr("checked")
        $("#additional_rule").show().focus()
      else
        $("#additional_rule").hide()
    defaultEndDate = 3
    datepickerOptions =
      minDate: 3
      maxDate: 30
    @datepicker.datepicker(datepickerOptions)
    today = new Date()

    endDate = new Date(today.getTime() + defaultEndDate * 86400 * 1000)
    @datepicker.datepicker('setDate',endDate)