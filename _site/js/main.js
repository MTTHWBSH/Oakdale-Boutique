(function() {
  var heroSize, loadMorePosts, showContent;

  $(document).ready(function() {
    heroSize();
    $('.loadMore').click(loadMorePosts);
  });

  $(window).load(function() {
    showContent();
  });

  $(window).resize(function() {
    heroSize();
  });

  $(function() {
    $('a[href*=#]:not([href=#])').click(function() {
      var target;
      if (location.pathname.replace(/^\//, '') === this.pathname.replace(/^\//, '') && location.hostname === this.hostname) {
        target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
        if (target.length) {
          $('html,body').animate({
            scrollTop: target.offset().top
          }, 1000);
          return false;
        }
      }
    });
  });

  heroSize = function() {
    $(".hero").css({
      height: ($(window).height() - 50) + "px"
    });
    $(".parallax-content").css('margin-top', ($(window).height()) + "px");
  };

  showContent = function() {
    $(".page-content").addClass("load");
  };

  loadMorePosts = function() {
    var $nextPage, $posts, $totalPages, _this;
    _this = this;
    $posts = $('.post-list');
    $nextPage = $posts.data('page') + 1;
    $totalPages = $posts.data('totalpages');
    if ($nextPage === $totalPages) {
      $('.loadMore').hide();
    }
    $(_this).addClass('loading');
    return $.get('/page' + $nextPage, function(data) {
      var $post, htmlData;
      htmlData = $.parseHTML(data);
      $post = $(htmlData).find('.post-preview');
      $posts.attr('data-page', $nextPage).append($post);
      return $(_this).removeClass('loading');
    });
  };

}).call(this);
