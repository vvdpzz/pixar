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

  check : (checkedList,title,content) ->
    tipStr = "您还没完成:&nbsp&nbsp&nbsp&nbsp"
    tipBool = false
    tipNum = 1
    if checkedList.length is 0
      tipStr += tipNum + '.' + "规则的选择&nbsp&nbsp&nbsp"
    	 tipBool = true
 	    tipNum++
 	  if title.val() is ""
      tipStr += tipNum + '.' + "标题的规定&nbsp&nbsp&nbsp"
 		   tipBool = true
      tipNum++
 	  if content.text() is ""
	    tipStr += tipNum + '.' + "内容的完善"
		   tipBool = true
    Pixar.notifyBar(tipStr,'提示:') if tipBool is true
    tipBool
    
    
class Pixar.Collections.QuestionsCollection extends Backbone.Collection
  model: Pixar.Models.Question
  url: '/questions'