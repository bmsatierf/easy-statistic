$(document).ready(function() {
  $('#submit_discrete_form').click(function(){ submitForm('discrete'); });
  $('#submit_continuous_form').click(function(){ submitForm('continuous'); });

  function submitForm(action) {
    $('#distribution_type').val(action);
    $('#distribution_type').submit();
  }

  $('#data_tab a').click(function (e) { e.preventDefault(); $(this).tab('show'); });

  $('.alert').fadeIn();

  // Normal distribution
  hideAndClearFormInputs();

  $('#calculation-type').change(function(){ toggleInputs($(this).val()); });

  function toggleInputs(idx) {
    switch(idx) {
      case "greater-than":
        hideAndClearFormInputs();
        $('#greater-than').fadeIn();
        break;
      case "less-than":
        hideAndClearFormInputs();
        $('#less-than').fadeIn();
        break;
      case "between":
      case "less-and-greater-than":
        hideAndClearFormInputs();
        $('#less-than').fadeIn();
        $('#end').fadeIn();
        $('#greater-than').fadeIn();
        break;
      default:
        $('#probability-question').fadeOut();
        $('#probability-answer').fadeOut();
        $('#less-than').fadeOut();
        $('#end').fadeOut();
        $('#greater-than').fadeOut();
        $('#calculate').fadeOut();
        return;
    }

    $('#calculate').fadeIn();
  }

  function hideAndClearFormInputs(){
    $('#probability-question').hide();
    $('#probability-answer').hide();
    $('#less-than').val("").hide();
    $('#end').hide();
    $('#greater-than').val("").hide();
    $('#calculate').hide();
  }

  $('input[type="number"]').keydown(function(e) {
    if(!isNumericInput(e)){ e.preventDefault(); }
  });

  $('.form-group input[type="number"]').keyup(function(e) {
    if(isNumericInput(e)){ handleProbabilityQuestion(this); }
  });

  function isNumericInput(event){ if(!(event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 190 || event.keyCode == 46 || (event.keyCode >= 35 && event.keyCode <= 40) || (event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105))) { return false; } else { return true; } }

  $('.form-group input[type="number"]').change(function(e) {
    handleProbabilityQuestion(this);
  });

  function handleProbabilityQuestion(input){
    $('#probability-answer').hide();
    $('#probability-question').hide();

    if($(input).val()) {
      switch($('#calculation-type').val()) {
        case "greater-than":
          $('#probability-question').html('maior que ' + $('#greater-than').val() + '?');
          break;
        case "less-than":
          $('#probability-question').html('menor que ' + $('#less-than').val() + '?');
          break;
        case "between":
          if($('#less-than').val() && $('#greater-than').val()) {
            $('#probability-question').html('entre ' + $('#less-than').val() + ' e ' + $('#greater-than').val() + '?');
          } else {
            return;
          }
          break;
        case "less-and-greater-than":
          if($('#less-than').val() && $('#greater-than').val()) {
            $('#probability-question').html('menor que ' + $('#less-than').val() + ' e maior que ' + $('#greater-than').val() + '?');
          } else {
            return;
          }
          break;
      }

      $('#probability-question').fadeIn();
    }
  }

  $('#normal-distribution').submit(function(e){
    e.preventDefault();

    $('#probability-answer').hide();

    $('#calculate').blur();
    $('#calculate').attr('disabled', 'disabled');
    $('#calculate').val('Aguarde ...');

    $('#ajax-loader').fadeIn();

    $.ajax({
      url: "/normal-distribution",
      data: $(this).serialize(),
      dataType: "json",
      success: function(data) {
        console.log(data);
        $('#ajax-loader').fadeOut(function(){
          $('#probability-value').html(data.probability);
          $('#probability-answer').fadeIn();
          $('#calculate').removeAttr('disabled');
          $('#calculate').val('Calcular');
        });
      }
    });
  });

  // Handling 'mean' and 'standard-deviation' changes
  $('#edit-mean').click(function (e) {
    e.preventDefault();
    $('#edit-mean').hide();
    $('#mean-value').fadeIn();
    $('#update-mean').fadeIn();
  });

  $('#update-mean').click(function (e) {
    $('#mean-value').hide();
    $('#update-mean').hide();
    $('#edit-mean').html($('#mean-value').val());
    $('#edit-mean').fadeIn();
  });

  $('#edit-standard-deviation').click(function (e) {
    e.preventDefault();
    $('#edit-standard-deviation').hide();
    $('#standard-deviation-value').fadeIn();
    $('#update-standard-deviation').fadeIn();
  });

  $('#update-standard-deviation').click(function (e) {
    $('#standard-deviation-value').hide();
    $('#update-standard-deviation').hide();
    $('#edit-standard-deviation').html($('#standard-deviation-value').val());
    $('#edit-standard-deviation').fadeIn();
  });
});
