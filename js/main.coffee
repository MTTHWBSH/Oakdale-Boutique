---
# Front Matter comment for Jekyll
---

$(document).ready ->
	heroSize()
	blog.init
	return

$(window).load ->
	showContent()
	return

$(window).resize ->
	heroSize()
	return

$ ->
  $('a[href*=#]:not([href=#])').click ->
    if location.pathname.replace(/^\//, '') == @pathname.replace(/^\//, '') and location.hostname == @hostname
      target = $(@hash)
      target = if target.length then target else $('[name=' + @hash.slice(1) + ']')
      if target.length
        $('html,body').animate { scrollTop: target.offset().top }, 1000
        return false
    return
  return

heroSize = ->
	$(".hero").css height: ($(window).height() - 50) + "px"
	$(".parallax-content").css('margin-top', ($(window).height()) + "px")
	return

showContent = ->
	$(".page-content").addClass "load"
	return

blog = 
  loadMorePosts: ->
    _this = this
    $blogContainer = $('.post-list')
    nextPage = parseInt($blogContainer.attr('data-page')) + 1
    totalPages = parseInt($blogContainer.attr('data-totalPages'))
    $(this).addClass 'loading'
    $.get '/blog/page' + nextPage + '/', (data) ->
      htmlData = $.parseHTML(data)
      $articles = $(htmlData).find('article')
      $blogContainer.attr('data-page', nextPage).append $articles
      if $blogContainer.attr('data-totalPages') == nextPage
        $('.load-more-posts').remove()
      $(_this).removeClass 'loading'
      return
    return
  bindUiEvents: ->
    $('pre').click ->
      $(this).toggleClass 'expanded'
      return
    $('.blog__back-to-site').click ->
      _this = this
      $('body').fadeOut 'slow', ->
        window.location.href = $(_this).attr('href')
        return
      false
    $('.load-more-posts').click blog.loadMorePosts
    return
  bindGAEvents: ->
    $('section.comments form').submit ->
      ga 'send', 'event', 'Comments', 'New comment'
      return
    return
  init: ->
    if document.referrer == 'http://oakdaleboutique.com/' or document.referrer == 'http://oakdaleboutique.com/#' or document.referrer == 'https://oakdaleboutique.com/' or document.referrer == 'https://oakdaleboutique.com/#'
      $('body').hide().fadeIn 'slow'
    blog.bindUiEvents()
    blog.bindGAEvents()
    return