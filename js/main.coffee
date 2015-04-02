---
# Front Matter comment for Jekyll
---

$(document).ready ->
	heroSize()
	return

$(window).load ->
	showContent()
	return

$(window).scroll (e) ->
	parallax()
	return

$(window).resize ->
	heroSize()
	return

parallax = ->
	scrolled = $(window).scrollTop()
	$(".hero").css "top", -(scrolled * 0.0315) + "rem"
	$(".hero .content").css "top", -(scrolled * -0.005) + "rem"
	return

heroSize = ->
	$(".hero").css height: ($(window).height() - 50) + "px"
	$(".parallax-content").css('margin-top', ($(window).height()) + "px")
	return

showContent = ->
	$(".page-content").addClass "load"
	return
