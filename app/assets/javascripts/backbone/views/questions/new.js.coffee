class App.Views.New extends Backbone.View
  template: JST["backbone/templates/questions/new"]
  
  events:
    "submit #new_question": "save"
    "click #pay": "choose_pay"
    "click #free": "choose_free"
    "keyup #title": "titleCountDown"
    "keyup .nicEdit-main": "contentCountDown"
    "click #payment_terms": "clearPaymentTips"
  initialize: () ->
    _.bindAll(this, 'render', 'initEffect','checkPost','checkNum')
  
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
    if $('#radio_customized_credit').attr('checked')
      checked_credit = $('#customized_credit').val()
    else 
      checked_credit = 0
    if $('#radio_customized_reputation').attr('checked')
      customized_reputation = $('#customized_reputation').val()
    else 
      customized_reputation = 0
    return false unless @checkPost(@is_titleReady,@$('#new_question').find('.nicEdit-main').text().length,checked_credit,customized_reputation)
    @model.set({
      title: @$("#title").val(),
      content: @$('#new_question').find('.nicEdit-main').html(),
      rules_list: checkedList.join(','),
      customized_rule: @$("#additional_rule").val(),
      end_date: @$("#date_picker").val(),
      is_community: @is_community
    })
    @model.save({},
      success: (question) =>
        @model = question
        window.location.hash = "!/#{@model.id}"
      error: (question, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )
  checkPost:(isTitle,contentLen,otherCredit,otherReputation)->
    unless questionBool
      $("#credit_Tips").hide()
      $("#reputation_Tips").hide()
    questionBool = true
    unless isTitle
      $('#title_limit_num').text("标题不能为空").addClass('negative')
      questionBool = false
    if contentLen is 0 
      $('#content_Tips').text('内容不能为空').addClass('negative')
      questionBool = false
    unless @checkNum(otherCredit)
      $('#credit_Tips').text('请输入正确的金额').addClass('negative')
      $("#credit_Tips").slideDown(200)
      questionBool = false
    unless @checkNum(otherReputation)
      $('#reputation_Tips').text('请输入的正确的数字').addClass('negative')
      $("#reputation_Tips").slideDown(200)
      questionBool = false
    return questionBool
  clearPaymentTips: ->
    $("#payment_terms .negative").hide()
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
  
  titleCountDown: ->
    maxLength = 70
    numDiv = $('#title_limit_num')
    titleInput = $("#title")
    if(titleInput.val())
      limit_num = maxLength - titleInput.val().length;
      numDiv.text(limit_num)
      if(limit_num<0)
        numDiv.addClass('negative')
        @is_titleReady = false
      else
        numDiv.removeClass('negative')
        @is_titleReady = true
    else
      numDiv.text(maxLength);
      @is_titleReady = false
  
  
  checkNum:(str)->
    mynumber="0123456789"; 
    i = 0
    if(str.length is 0)
      return false
    while i < str.length
      c=str.charAt(i)
      if(mynumber.indexOf(c) is -1) 
        return false
      i++        
    true
  
  contentCountDown: ->
    maxLength = 1000
    numDiv = $('#content_Tips')
    titleInput = $(".nicEdit-main")
    if(titleInput.text())
      limit_num = maxLength - titleInput.text().length;
      numDiv.text(limit_num)
      if(limit_num<0)
        numDiv.addClass('negative')
        @is_titleReady = false
      else
        numDiv.removeClass('negative')
        @is_titleReady = true
    else
      numDiv.text(maxLength);
      @is_titleReady = false
  
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