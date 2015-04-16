---
# Front Matter comment for Jekyll
---

$(document).ready ->
  heroSize()
  $('.loadMore').click loadMorePosts
  return

$(window).scroll (e) ->
  parallax()
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

parallax = ->
  scrolled = $(window).scrollTop()
  $(".hero").css "top", -(scrolled * 0.0115) + "rem"
  return

loadMorePosts = ->
  _this = this
  $posts = $('.post-list')
  $nextPage = $posts.data('page') + 1
  $totalPages = $posts.data('totalpages')
  if $nextPage == $totalPages
    $('.loadMore').hide()
  $(_this).addClass 'loading'
  $.get '/page' + $nextPage, (data) ->
    htmlData = $.parseHTML(data)
    $post = $(htmlData).find('.post-preview')
    $posts.attr('data-page', $nextPage).append $post
    $(_this).removeClass 'loading'
