 $(document).on 'change', '#input_text', (evt) ->
 	if($("#input_text").val().length == 0)
 		$(".alert-warning").hide().empty()
 	else	
    $.ajax 'decoder/isEncoded',
      type: 'POST',
      dataType: 'script',
      contentType: "application/json; charset=utf-8"
      data: JSON.stringify({
        content: $("#input_text").val()
      })
      	
