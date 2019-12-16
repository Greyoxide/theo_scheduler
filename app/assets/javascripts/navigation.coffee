$( document ).on 'turbolinks:load', ->
  $('#burger, #menu a').click ->
	  $('#burger').toggleClass("active")
	  $('#menu').toggleClass("active")
	  $('#navigation').toggleClass("active")