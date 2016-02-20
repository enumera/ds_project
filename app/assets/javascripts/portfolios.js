$(function(){


	function collectFund(rowSelected){
    
    	
	    $this = rowSelected
	    $this.toggleClass('selected');

	    // var  selectedRow = $this;
	    var td = $this.children('td');
	    var fundDetails = [];
	     // debugger;
	       for (var i = 0; i < td.length; ++i) {
	        fundDetails.push(td[i].innerText);
	        // alert(i + ': ' + td[i].innerText);
	        } 

	     return fundDetails; 
	     
	   
	};

	$(document.body).on("click", ".add_fund_link", function(){


		var fund = $(this).val();
		var fundDets = [];
		var fund_count = $("#portfolio_table tr").length
		fund_count = fund_count;


		funddetails = collectFund($(this).closest('tr'));


		$("#portfolio_table").append("<tr id="+ funddetails[1] +"><td>"+funddetails[1] + "<input type='hidden' name='portfolio_record_" +fund_count+"[fund_id]' value="+funddetails[0] +"></td><td><input type='text' name='portfolio_record_" +fund_count+"[allocation]' size='10' class='allocate'></input>%</td><td class='allocate_money'>£ 0.00</td></tr>");
	});

	$(document.body).on("keyup", ".allocate", function(){
		var record = $(this).closest("tr");
		var percent = parseFloat($(this).val());
		var total = parseInt($("#portfolio_total_funding").val());
		console.log(percent);
	
		
		var money_allocated = (percent * total)/100;
		console.log(money_allocated)
		$("#"+ record.attr("id") + " .allocate_money").text("£" + money_allocated);
	});

	$(document.body).on("keyup", "#portfolio_total_funding", function(){

		if($("#portfolio_total_funding").val() == "" && $("#portfolio_table tr").length > 1){

		 	$(".allocate_money").text("£-");
		}else{
			var total = parseInt($("#portfolio_total_funding").val());
			var fund_rows = $("#portfolio_table tr");
			var len = fund_rows.length

			for (i = 0; i < len; i ++){
				var fr = $(fund_rows[i]).attr("id");
				var percent = parseFloat($("#" +fr + " .allocate").val());
				var money_allocated = (percent * total)/100;
				$("#"+ fr + " .allocate_money").text("£" + money_allocated);
			};
		};
	});

	


});
