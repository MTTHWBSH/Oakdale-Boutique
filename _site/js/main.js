(function() {
  var heroSize, parallax, showContent;

  $(document).ready(function() {
    heroSize();
  });

  $(window).load(function() {
    showContent();
  });

  $(window).scroll(function(e) {
    parallax();
  });

  $(window).resize(function() {
    heroSize();
  });

  parallax = function() {
    var scrolled;
    scrolled = $(window).scrollTop();
    $(".hero").css("top", -(scrolled * 0.0315) + "rem");
    $(".hero .content").css("top", -(scrolled * -0.005) + "rem");
    $(".hero .content").css("opacity", 1 - (scrolled * .00175));
  };

  heroSize = function() {
    $(".hero").css({
      height: ($(window).height()) + "px"
    });
    $(".parallax-content").css('margin-top', ($(window).height()) + "px");
  };

  showContent = function() {
    $(".page-content").addClass("load");
  };

}).call(this);
