Pixar.Views.Questions ||= {}
class Pixar.Views.Questions.NewView extends Backbone.View    
  template: JST["backbone/templates/questions/new"]
  
  events:
    "submit #new-question": "save"
  initialize: () ->
    _.bindAll(this, 'render', 'initEffect')
  
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
		
    allCheckedRules = @$('#new-question').find('input[type=checkbox]:checked')
    checkedList = (parseInt($(e).attr('id').slice(6),10) for e in allCheckedRules)
    check = @model.check(checkedList,$("#title"),@$('#new-question').find('.nicEdit-main'));
    if check is true
      false
    else
      @model.set({
        content: @$('#new-question').find('.nicEdit-main').html(),
        rules_list: checkedList.join(',')
      })
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
      #         $("#anim").change ->
      # $("#datepicker").datepicker("option","showAnim",$(this).val());
