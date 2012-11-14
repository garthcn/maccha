$(document).ready(function() {
  var $dlg = $('#billing'),
    $planName = $dlg.find('.plan strong'),
    $buyerType = $('#buyer_type'),
    $sellerType = $('#seller_type');

  // $('.plans').delegate('.activate', 'click', function(e) {
  //   var $this = $(this), name = $this.data('name'),
  //     btype = $this.data('btype'), stype = $this.data('stype');
  //   $planName.text(name);
  //   if (btype) {
  //     $buyerType.val(btype);
  //     $sellerType.val(0);
  //   }
  //   if (stype) {
  //     $buyerType.val(0);
  //     $sellerType.val(stype);
  //   }
  // });
});

