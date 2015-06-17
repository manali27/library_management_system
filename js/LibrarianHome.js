$(document).ready(function(){
	$('input[type="radio"]').click(function(){
		if($(this).attr("value")=="on"){
			$("#issuedBooks").hide();
			$("#categoryBooks").hide();
			$("#allBooks").show();
		}
		if($(this).attr("value")=="off"){
			$("#issuedBooks").show();
			$("#categoryBooks").hide();
			$("#allBooks").hide();
		}
		if($(this).attr("value")=="other"){
			$("#issuedBooks").hide();
			$("#categoryBooks").show();
			$("#allBooks").hide();
		}
	});
	
	$( "#book_category" ).change(function() {
		  var id=$( "#book_category" ).val();
		  $.ajax({
			type:	"get",
			url:	"CategoryWiseBooks.jsp",
			data:	"id=" + id,
			success: function(msg){
				console.log("got message");
				$('#categoryBooksTable').hide();
				$('#categoryBooksTable').html(msg).fadeIn("fast");
			},
			error:	function(xhr,ajaxOptions,thrownError){
				console.log(xhr.status);
				console.log(thrownError);
			}
		});
	});
	
	$(document).on("click","#uname_btn", function (e) {
		var uname = $(this).text();
		$.ajax({
			type:	"get",
			url:	"MemberWiseBooks.jsp",
			data:	"uname=" + uname,
			success: function(msg){
				console.log("got message");
				$('#unameBookTable').hide();
				$('#unameBookTable').html(msg).fadeIn("fast");
			},
			error:	function(xhr,ajaxOptions,thrownError){
				console.log(xhr.status);
				console.log(thrownError);
			}
		});
	});
	$(document).on("click","#calc_fine",function(e){
		startDate=$(this).attr("data-startdate");
		var id=$(this).attr("data-bookid");
		endDate=$("."+$(this).attr("data-bookid")+"-endDate").val();
		if(endDate==""){
			alert("Plase Select return date first.")
		}
		else{
			$.ajax({
				type:	"get",
				url:	"CalculateFine.jsp",
				data:	"act_return_date="+startDate+"&exp_return_date="+endDate,
				success: function(msg){
					var days=parseInt(msg);
					var fine=0;
					if(days<=0){
						fine=0;
					}
					else{
						fine=days*5;
					}
					$("."+id+"-fine").html(fine);
				},
				error:	function(xhr,ajaxOptions,thrownError){
					console.log(xhr.status);
					console.log(thrownError);
				}
			});
		}
	});
	
	$(document).on("click","#return",function(e){
		var book_id = $(this).attr("data-bkid");
		var member_id = $(this).attr("data-memid");
		returnDate=$("."+$(this).attr("data-bkid")+"-endDate").val();
		if(returnDate==""){
			alert("Plase Select return date first.");
		}
		else{
			//alert("Actual return date "+returnDate);
			$.ajax({
				type:	"get",
				url:	"ReturnBook.jsp",
				data:	"book_id="+book_id+"&member_id="+member_id+"&act_return_date="+returnDate,
				success: function(msg){
					console.log("got message");
					alert("Book returned successfully");
					$("#return_date").html(returnDate).fadeIn("fast");
				},
				error:	function(xhr,ajaxOptions,thrownError){
					console.log(xhr.status);
					console.log(thrownError);
				}
			});
		}
	});
});