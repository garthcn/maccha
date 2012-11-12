(function($) {

  var Item = {
    init: function() {
      $('.datepicker').datepicker({
        format: 'yyyy-mm-dd'
      });

      $('.timepicker').timepicker();
      Item.bindBuyBtn();
    },

    bindBuyBtn: function() {
      $('#buyitnow').click(function(e) {
        $('#billing').modal('show');
      });
    }
          
  }
  $(document).ready(Item.init);

})(jQuery);
