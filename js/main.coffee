---
# Front Matter comment for Jekyll
---

$(document).ready ->
  heroSize()
  $('.loadMore').click loadMorePosts
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
  $(".hero").css height: ($(window).height()) + "px"
  return

showContent = ->
  $(".page-content").addClass "load"
  return

loadMorePosts = ->
  _this = this
  $posts = $('.post-list')
  $nextPage = $posts.data('page') + 1
  $totalPages = $posts.data('totalpages')
  console.log $nextPage, $totalPages
  if $nextPage == $totalPages
    $('.loadMore').hide()
  $(_this).addClass 'loading'
  $.get '/page' + $nextPage, (data) ->
    htmlData = $.parseHTML(data)
    $post = $(htmlData).find('.post-preview')
    $posts.data('page', $nextPage).append $post
    $(_this).removeClass 'loading'
