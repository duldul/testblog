jQuery ->
  $(".comment-form form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea, input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (data, status, xhr) ->
      console.log('ajax:success');
      $(this).find('textarea, input')
        .removeAttr('disabled', 'disabled');
      $(this).find('textarea, input[type="text"]').val('');
    .on "ajax:error", (xhr, status, error) ->
      console.log('ajax:error');