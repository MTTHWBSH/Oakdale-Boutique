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
  $(".hero").css height: ($(window).height() - 50) + "px"
  $(".parallax-content").css('margin-top', ($(window).height()) + "px")
  return

showContent = ->
  $(".page-content").addClass "load"
  return

loadMorePosts = ->
  _this = this
  $posts = $('.post-list')
  nextPage = parseInt($posts.attr('data-page')) + 1
  totalPages = parseInt($posts.attr('data-totalPages'))
  $(this).addClass 'loading'
  $.get '/page' + nextPage, (data) ->
    htmlData = $.parseHTML(data)
    $post = $(htmlData).find('.post-preview')
    $posts.attr('data-page', nextPage).append $post
    console.log($posts.attr('data-page'), totalPages)
    if $posts.attr('data-page') == totalPages
      $('.loadMore').remove()
      console.log("they are the same")
    $(_this).removeClass 'loading'
    return
  return
