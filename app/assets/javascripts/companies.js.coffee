$(document).on "click", "#company_slide", ->
  $("#description_slide_down").toggle "slideDown(1000)", ->

$(document).on "click", "#company_target_slide", ->
  $("#target_price_slide_down").toggle "slideDown(1000)", ->
  $("#new_target_price").enableClientSideValidations()

$(document).on "click", "#company_competitor_slide", ->
  $("#competitor_slide_down").toggle "slideDown(1000)", ->

$(document).on "click", "#add_question_link", ->
  $("#question_content").val(null)
  $("#add_question_form").toggle "slideDown(1000)", ->