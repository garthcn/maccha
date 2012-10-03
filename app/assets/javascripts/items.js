(function($) {

  var Item = {
    init: function() {
      $('.datepicker').datepicker({
        format: 'yyyy-mm-dd'
      });

      $('.timepicker').timepicker();
    }
  }
  $(document).ready(Item.init);

})(jQuery);
