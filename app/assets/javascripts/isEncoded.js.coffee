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
  chars_data=[]    
  f=(String.fromCharCode(x+64) for x in [1..26])
		f.map (i)->
			chars_data.push ($("#input_text").val().match(new RegExp(i.toLowerCase(), "g")) || []).length
  data = {
    labels : (String.fromCharCode(x+64) for x in [1..26]),
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : chars_data
      }
    ]
  }
  $(".canvas").empty().append('<canvas id="chars_chart" style="width:100%; height: 400px;"></canvas>') 
  context = document.getElementById('chars_chart').getContext('2d');
  myNewChart = new Chart(context).Bar(data)   
 
