$(document).on "click", ".nModal", (e) ->
  e.preventDefault()
  $(this).nyroModal()
  $("#register-form").enableClientSideValidations()
  $("#signin-form").enableClientSideValidations()

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

$(document).on "change", "#company_buy_sort", ->
  company_slug = $("#company-slug").data("slug")
  $.ajax url: "/companies/" + company_slug + "/buypitch?sort_by="+$('#company_buy_sort').val()

$(document).on "change", "#company_sell_sort", ->
  company_slug = $("#company-slug").data("slug")
  $.ajax url: "/companies/"+ company_slug + "/sellpitch?sort_by="+$('#company_sell_sort').val()

$(document).on "change", "#company_questions_sort", ->
  company_slug = $("#company-slug").data("slug")
  $.ajax url: "/companies/"+ company_slug + "/questions?sort_by="+$('#company_questions_sort').val()

# $(document).on "change", "#company_blip_sort", ->
#   company_slug = $("#company-slug").data("slug")
#   $.ajax url: "/companies/"+ company_slug + "/blips?sort_by="+$('#company_blip_sort').val()
jQuery ->
  $('#companies').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $("#companies").data('source')
