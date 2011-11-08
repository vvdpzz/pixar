class App.Views.New extends Backbone.View
  template: JST["backbone/templates/questions/new"]
  
  events:
    "submit #new_question": "save"
    "click #pay": "choose_pay"
    "click #free": "choose_free"
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
    allCheckedRules = @$('#new_question').find('input[type=checkbox]:checked')
    checkedList = (parseInt($(e).attr('id').slice(6),10) for e in allCheckedRules)
    @model.set({
      title: @$("#title").val(),
      content: @$('#new_question').find('.nicEdit-main').html(),
      rules_list: checkedList.join(','),
      customized_rule: @$("#additional_rule").val(),
      end_date: @$("#date_picker").val(),
      is_community: @is_community
    })
    @model.save(
      success: (question) =>
        @model = question
        window.location.hash = "/#{@model.id}"
      error: (question, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
        
  choose_pay: ->
    if @is_community
      @is_community = false
      $('#payment_terms').show()
      $('#free').removeClass('active')
      $('#pay').addClass('active')
  
  choose_free: ->
    unless @is_community
      @is_community = true
      $('#payment_terms').hide()
      $('#pay').removeClass('active')
      $('#free').addClass('active')
  
  render: ->
    $(this.el).html(@template(@model.toJSON() ))
    @$("form").backboneLink(@model)
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