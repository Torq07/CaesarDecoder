 $(document).on 'change', '#input_text', (evt) ->
    $.ajax 'decoder/isEncoded',
      type: 'POST',
      dataType: 'script',
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify({
        content: $("#input_text").val()
      })
     