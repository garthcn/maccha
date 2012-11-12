(function($) {

  var Home = {
    init: function() {
      $('div.user-menu').on("mouseenter", function() {
          //$(this).addClass('open');
          $('ul.dropdown-menu').fadeIn(400);
      });
      $('div.user-menu').on("mouseleave", function() {
          //$(this).removeClass('open')
          $('ul.dropdown-menu').fadeOut(400);
      });
    }
  }
  $(document).ready(Home.init);

})(jQuery);
