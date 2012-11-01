(function($) {

  var Home = {
    init: function() {
      $('div.user-menu').hover(
        function() {
          //$(this).addClass('open');
          $('ul.dropdown-menu').fadeIn(400);
        },
        function() {
          //$(this).removeClass('open')
          $('ul.dropdown-menu').fadeOut(400);
        }
      );
    }
  }
  $(document).ready(Home.init);

})(jQuery);
