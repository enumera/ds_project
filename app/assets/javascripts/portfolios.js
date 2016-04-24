$(function(){


	function updateRecords(){

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



	function updateCash(){
		var totalAmount = parseInt($("#portfolio_total_funding").val());
		var fund_rows = $("#portfolio_table tr");
		var len = fund_rows.length;
		var totalMoneyAllocated = totalAmount;
		var money_allocated = 0.00;

		console.log("fund rows " + fund_rows.length);

		if(fund_rows.length > 1){


			for (i = 1; i < len; i ++){
				var fr = $(fund_rows[i]).attr("id");
				var percent = parseFloat($("#" +fr + " .allocate").val());

				if(percent === undefined || percent === null || percent == 0.00){
					money_allocated = money_allocated;
				}else{
					money_allocated = money_allocated+ (percent * totalAmount)/100;
				};
					

				totalMoneyAllocated = totalAmount -  money_allocated;
					// $("#"+ fr + " .allocate_money").text("£" + money_allocated);
			};
		};
			console.log("money allocated "+ money_allocated );
			console.log("total Money Allocated "+ totalMoneyAllocated );

			
			
			$('#cash_funding').text("£ " + totalMoneyAllocated);

			if(totalMoneyAllocated > 0 && money_allocated > 0){
				$('#cash_allocation').text(totalMoneyAllocated/totalAmount*100 + "%");
			}else{
				$('#cash_allocation').text("100%");

			};
	};

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

		$("#portfolio_table").append("<tr id="+ funddetails[0] +"><td>"+funddetails[1] + "<input type='hidden' name='portfolio_record_" +fund_count+"[fund_id]' value="+funddetails[0] +"></td><td><input type='text' name='portfolio_record_" +fund_count+"[allocation]' size='10' class='allocate'></input>%</td><td class='allocate_money'>£ 0.00</td><td class='price'>" +funddetails[5] + "</td><td class='remove'><a href='#' class='removeLink'> Remove</a></td></tr>");
	});



	$(document.body).on("keyup", ".allocate", function(){
		var record = $(this).closest("tr");
		var percent = parseFloat($(this).val());
		var total = parseInt($("#portfolio_total_funding").val());
		// console.log(percent);
		var money_allocated = (percent * total)/100;
		// console.log(money_allocated)
		$("#"+ record.attr("id") + " .allocate_money").text("£" + money_allocated);
		updateCash();
	});

	$(document.body).on("keyup", "#portfolio_total_funding", function(){

		if($("#portfolio_total_funding").val() == "" && $("#portfolio_table tr").length > 1){

		 	$(".allocate_money").text("£-");
		 	updateCash();
		}else{
			updateRecords();
			// var total = parseInt($("#portfolio_total_funding").val());
			// var fund_rows = $("#portfolio_table tr");
			// var len = fund_rows.length

			// for (i = 0; i < len; i ++){
			// 	var fr = $(fund_rows[i]).attr("id");
			// 	var percent = parseFloat($("#" +fr + " .allocate").val());
			// 	var money_allocated = (percent * total)/100;
			// 	$("#"+ fr + " .allocate_money").text("£" + money_allocated);
			// };
			updateCash();
		};

	});


	$(document.body).on("click", ".removeLink", function(){
		var removeRow = $(this).closest('tr');
		
		$("#" + removeRow.attr("id") +" .allocate").val(0.00)
		$("#" + removeRow.attr("id") +" .allocate_money").val(0.00)
		removeRow.fadeOut();

		// console.log($("#" + removeRow.attr("id") +" .allocate").val());
		// console.log($("#" + removeRow.attr("id") +" .allocate_money").val());
		updateRecords();
		updateCash();

	});
});
