$(document).ready(function() {
  function submitForm(action) {
    $('#distribution_type').val(action);
    $('#distribution_type').submit();
  }

  $('#submit_discrete_form').click(function(){ submitForm('discrete'); });
  $('#submit_continuous_form').click(function(){ submitForm('continuous'); });

  $('#data_tab a').click(function (e) { e.preventDefault(); $(this).tab('show'); });

  $('.alert').fadeIn();
});