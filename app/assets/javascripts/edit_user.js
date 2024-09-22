$(document).ready(function() {
  $(':input[value="Update"]').prop('disabled', true);
  $('input[type="text"]').keyup(function() {
   if($(this).val() != '') {
      $(':input[type="submit"]').prop('disabled', false);}
  });
  $('input[type="email"]').keyup(function() {
   if($(this).val() != '') {
      $(':input[type="submit"]').prop('disabled', false);
   }
   });
  $('input[type="password"]').keyup(function() {
   if($(this).val() != '') {
         $(':input[type="submit"]').prop('disabled', false);
      }
   });
  $('input[id="user_current_password"]').keyup(function() {
      if($(this).val() != '') {
         $(':input[value="Update"]').prop('disabled', false);
      }
   });
});
