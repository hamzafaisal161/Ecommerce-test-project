$(document).ready(function() {
  $(':input[type="submit"]').prop('disabled', true);
  $('input[type="text"]').keyup(function() {
     if($(this).val() != '') {
        $(':input[type="submit"]').prop('disabled', false);
     }
  });
  $('input[type="number"]').click(function() {
   if($(this).val() != '') {
      $(':input[type="submit"]').prop('disabled', false);
   }
   });
});
