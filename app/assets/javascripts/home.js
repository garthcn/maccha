(function($) {

  var Home = {
    init: function() {
      $('div.user-menu')
        .on('mouseover', function() {
          //$(this).addClass('open');
          $('ul.dropdown-menu').fadeIn(400);
        })
        .on('mouseleave', function() {
          //$(this).removeClass('open')
          $('ul.dropdown-menu').fadeOut(400);
        });
    }
  }
  $(document).ready(Home.init);

})(jQuery);
