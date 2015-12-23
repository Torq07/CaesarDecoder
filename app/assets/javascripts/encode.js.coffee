 $(document).on 'click', '.submitEncode', (evt) ->
    $.ajax 'decoder/encode',
      type: 'POST',
      dataType: 'script',
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify({
        content: $("#input_text").val(),
        shift: $("#shift").val()
      })
 $(document).on 'click', '.submitDecode', (evt) ->
    $.ajax 'decoder/encode',
      type: 'POST',
      dataType: 'script',
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify({
        content: $("#input_text").val(),
        shift: $("#shift").val()*-1
      })     
     