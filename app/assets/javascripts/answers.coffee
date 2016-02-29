# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

a = 5
b = 10 if a > 5

# this is a comment

capitalize = (string) ->
  string.charAt(0).toUpperCase() + string.slice(1)

titleize = (string) ->
  words = string.split(" ")
  (capitalize word for word in words).join(" ")

$ ->
  $(".my-btn").on "click", ->
    $(@).toggleClass("btn-danger")

  $("#my-box").keyup ->
    $("#output").html(titleize($("input[type='text']").val()))
