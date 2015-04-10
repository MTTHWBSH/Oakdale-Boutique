(function() {
  var blog, heroSize, showContent;

  $(document).ready(function() {
    heroSize();
    blog.init;
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

  blog = {
    loadMorePosts: function() {
      var $blogContainer, _this, nextPage, totalPages;
      _this = this;
      $blogContainer = $('.post-list');
      nextPage = parseInt($blogContainer.attr('data-page')) + 1;
      totalPages = parseInt($blogContainer.attr('data-totalPages'));
      $(this).addClass('loading');
      $.get('/blog/page' + nextPage + '/', function(data) {
        var $articles, htmlData;
        htmlData = $.parseHTML(data);
        $articles = $(htmlData).find('article');
        $blogContainer.attr('data-page', nextPage).append($articles);
        if ($blogContainer.attr('data-totalPages') === nextPage) {
          $('.load-more-posts').remove();
        }
        $(_this).removeClass('loading');
      });
    },
    bindUiEvents: function() {
      $('pre').click(function() {
        $(this).toggleClass('expanded');
      });
      $('.blog__back-to-site').click(function() {
        var _this;
        _this = this;
        $('body').fadeOut('slow', function() {
          window.location.href = $(_this).attr('href');
        });
        return false;
      });
      $('.load-more-posts').click(blog.loadMorePosts);
    },
    bindGAEvents: function() {
      $('section.comments form').submit(function() {
        ga('send', 'event', 'Comments', 'New comment');
      });
    },
    init: function() {
      if (document.referrer === 'http://oakdaleboutique.com/' || document.referrer === 'http://oakdaleboutique.com/#' || document.referrer === 'https://oakdaleboutique.com/' || document.referrer === 'https://oakdaleboutique.com/#') {
        $('body').hide().fadeIn('slow');
      }
      blog.bindUiEvents();
      blog.bindGAEvents();
    }
  };

}).call(this);
