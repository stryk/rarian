# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "change", "#home_buy_sort", ->
  $.ajax url: "/home/buypitch?sort_by="+$('#home_buy_sort').val()

$(document).on "change", "#home_buy_range", ->
  $.ajax url: "/home/buypitch?sort_by="+$('#home_buy_sort').val()+'&range='+$('#home_buy_range').val()

$(document).on "change", "#home_sell_sort", ->
  $.ajax url: "/home/sellpitch?sort_by="+$('#home_sell_sort').val()
$(document).on "change", "#home_sell_range", ->
  $.ajax url: "/home/sellpitch?sort_by="+$('#home_sell_sort').val()+'&range='+$('#home_sell_range').val()

$(document).on "change", "#home_blip_sort", ->
  $.ajax url: "/home/blips?sort_by="+$('#home_blip_sort').val()
  
$(document).on "change", "#home_blip_range", ->
  $.ajax url: "/home/blips?sort_by="+$('#home_blip_sort').val()+'&range='+$('#home_blip_range').val()