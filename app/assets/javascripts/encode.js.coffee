 $(document).on 'click', '.submit', (evt) ->
    $.ajax 'decoder/encode',
      type: 'POST',
      dataType: 'script',
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify({
        content: $("#input_text").val(),
        shift: $("#shift").val()
      })
     