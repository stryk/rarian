# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "click", "#mobile_number_edit", ->
  $("#show_mobile_number_div").toggle "slideDown(1000)", ->
  $("#user_mobile_form").enableClientSideValidations()
  false

$(document).on "click", "#email_lnk", ->
  $("#email").show "slideDown(1000)", ->
  $("#privacy").hide "slideDown(1000)", ->

$(document).on "click", "#privacy_lnk", ->
  $("#email").hide "slideDown(1000)", ->
  $("#privacy").show "slideDown(1000)", ->

$(document).on "click", "#new_pwd", ->
  $("#set_pwd_div").toggle "slideDown(1000)", ->
  $("#password_form").enableClientSideValidations()
  false

$(document).on "change", "#blip_sort_by", ->
  $.ajax url: "/users/blips?sort_by="+$('#blip_sort_by').val()+'&range='+$('#blip_range').val()

$(document).on "change", "#blip_range", ->
  $.ajax url: "/users/blips?sort_by="+$('#blip_sort_by').val()+'&range='+$('#blip_range').val()

$(document).on "change", "#buy_sort", ->
  $.ajax url: "/users/buypitch?sort_by="+$('#buy_sort').val()+'&range='+$('#buy_range').val()

$(document).on "change", "#buy_range", ->
  $.ajax url: "/users/buypitch?sort_by="+$('#buy_sort').val()+'&range='+$('#buy_range').val()

$(document).on "change", "#sell_sort", ->
  $.ajax url: "/users/sellpitch?sort_by="+$('#sell_sort').val()+'&range='+$('#sell_range').val()

$(document).on "change", "#sell_range", ->
  $.ajax url: "/users/sellpitch?sort_by="+$('#sell_sort').val()+'&range='+$('#sell_range').val()


$(document).on "change", "#question_sort", ->
  $.ajax url: "/users/question?sort_by="+$('#question_sort').val()+'&range='+$('#question_range').val()

$(document).on "change", "#question_range", ->
  $.ajax url: "/users/question?sort_by="+$('#question_sort').val()+'&range='+$('#question_range').val()


$(document).on "change", "#answer_sort", ->
  $.ajax url: "/users/answer?sort_by="+$('#answer_sort').val()+'&range='+$('#answer_range').val()

$(document).on "change", "#answer_range", ->
  $.ajax url: "/users/answer?sort_by="+$('#answer_sort').val()+'&range='+$('#answer_range').val()


$(document).on "change", "#comment_sort", ->
  $.ajax url: "/users/comment?sort_by="+$('#comment_sort').val()+'&range='+$('#comment_range').val()

$(document).on "change", "#comment_range", ->
  $.ajax url: "/users/comment?sort_by="+$('#comment_sort').val()+'&range='+$('#comment_range').val()