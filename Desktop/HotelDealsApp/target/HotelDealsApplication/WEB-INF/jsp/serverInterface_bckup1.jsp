<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" session="false"%>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!doctype html>

<html lang="en">
    <head>
    	
		<script type="text/javascript">
		
		var ratings = new Array();
		var prefferedBooksRating = new Array();
		var prefferedMovieRating = new Array();
		
		function rateMovie(divId,id,rating){
			if($("#Label3").html() == "Books" && divId == "dom_books")
			{
				prefferedBooksRating.push(id+":"+rating);
			}
			else if($("#Label3").html() == "Movies" && divId == "dom_movies")
			{
				prefferedMovieRating.push(id+":"+rating);
			}
			else
			{
				ratings.push(id+":"+rating);
			}
			unloadLightBox();
		}
		
		function getRecommendations()
		{
			checkForDomain();
			loadLightBoxLoader();
			if(ratings.length === 0)
			{
				alert("Please do ratings for us to recommend !!");
				unloadLightBoxLoader();
				return;
			}
			$.ajax({
					type : "GET",
					contentType: "application/json",         
					dataType: "json",
					url : "${pageContext.request.contextPath}/reccontroller/api/getRecommendedData?"
							+"ratings="+ratings+"&selectedFirstDomain="+$("#domain1 option:selected").val()+
							"&selectedSecondDomain="+$("#domain2 option:selected").val()+
							"&numOfRec="+$("#numOfRec option:selected").val()+
							"&algo="+$("#algo option:selected").val(),
					cache : false,
					error: function (request, status, error) {
						unloadLightBoxLoader();
              		  alert(status+" _"+error+"_"+request);
      	            }
					}).done(function(data)
					{   
    				$("#rec-data-detail").html("");   
    				if(null != data)
    				{
    		 			if(data.count < 1){                        			
    						$("#rec-data-detail").html("<tr><td colspan='7'><span>No Data</span></td></tr>");         
    						unloadLightBoxLoader();
    						prefferedBooksRating = [];
    						prefferedMovieRating = [];
    					}else {
    						if($("#Label3").html() == "Books")
							{
							
								populateDomain2Data(prefferedBooksRating,"bookImages");
							}
							else if($("#Label3").html() == "Movies")
							{
								
								populateDomain2Data(prefferedMovieRating,"movieImages");
							}
							insertdata(data.count,
									data.data,
									$("#domain2 option:selected").val());
						
						}
    				}
    				else
    				{
    					unloadLightBoxLoader();
    				}
					});
		}
		
		function getRecDataOnChange()
		{
			checkForDomain();
			loadLightBoxLoader();
			$.ajax({
					type : "GET",
					contentType: "application/json",         
					dataType: "json",
					url : "${pageContext.request.contextPath}/reccontroller/api/getRecDataOnChange?"
							+"selectedFirstDomain="+$("#domain1 option:selected").val()+
							"&selectedSecondDomain="+$("#domain2 option:selected").val()+"&numOfRec="+
							$("#numOfRec option:selected").val()+
							"&algo="+$("#algo option:selected").val(),
					cache : false,
					error: function (request, status, error) {
						unloadLightBoxLoader();
              		  alert(status+" _"+error+"_"+request);
      	            }
					}).done(function(data)
					{   
    				$("#rec-data-detail").html("");   
    				if(null != data)
    				{
    		 			if(data.count < 1){                        			
    						$("#rec-data-detail").html("<tr><td colspan='7'><span>No Data</span></td></tr>");         
    						unloadLightBoxLoader();
    					}else {
							insertdata(data.count,
									data.data,
									$("#domain2 option:selected").val());
						}
    				}
    				else
    				{
    					unloadLightBoxLoader();
    				}
					});
		}
		
		function updateRatingdiv()
		{
			ratings = [];
		  	var domain1 = $("#domain1 option:selected").val();
		  	if(domain1 == "-1")
		  	{
		  		return;
		  	}
		  	
		  	if(1 == domain1)
		  	{
		  		$("#Label1").html("Movies");
		  		$("#Label2").html("Rate Below");
		  		$("#recommendation").html("Recommended Books");
		  	}
		  	else if(2 == domain1)
		  	{
		  		$("#Label1").html("Books");
		  		$("#Label2").html("Rate Below");
		  		$("#recommendation").html("Recommended Movies");
		  	}
		  	
		  	loadLightBoxLoader();
		  	
		  	var domain1tableId = document.getElementById("first_domain1_div").getElementsByTagName("TABLE")[0].id;
			$("#bookDetailTable").html("");
		    var x = $("#"+domain1tableId).detach();
		    
		    if(domain1tableId == 'dom_books' || domain1tableId == 'dom_movies')
		    {
		    	$("#temp").prepend(x);
		    }
		    
			deleteRefreshButtons();
	      
		    if(1 == domain1)
		    {
		    	$("#first_domain1_div").append($("#dom_movies"));
		    	document.getElementById("dom_movies").style.display="table";
				unloadLightBoxLoader();
				$('#dom_movies').tablePagination({});
				$("#Label3").html("Books");
				$("#domain2Data").append($("#dom_books"));
				document.getElementById("dom_books").style.display="table";
				$('#dom_books').tablePagination({});
		    }
			else if(2 == domain1)
			{
		    	$("#first_domain1_div").append($("#dom_books"));
		    	document.getElementById("dom_books").style.display="table";
				unloadLightBoxLoader();
				$('#dom_books').tablePagination({});
				$("#Label3").html("Movies");
				$("#domain2Data").append($("#dom_movies"));
				document.getElementById("dom_movies").style.display="table";
				$('#dom_movies').tablePagination({});
			}
		  	
			$("#Label2").html("Rate Below");
		    
// 		  	if(1 == domain1)
// 		  		insertDataForMovies(movieListSize,imagePath);
// 		  	else if(2 == domain1)
// 			  	insertDataForBooks(bookListSize,imagePath);		
// 		  	unloadLightBoxLoader();
		  
		  	
// 		  	$.ajax({
// 				type : "GET",
// 				contentType: "application/json",         
// 				dataType: "json",
//   				url : "${pageContext.request.contextPath}/reccontroller/api/getDomain1List?" 
// 						+"selectedFirstDomain="+domain1,
// 				cache : false,
// 				error: function (request, status, error) {
// 					unloadLightBoxLoader();
//           		  	alert(status+" _"+error+"_"+request);
//   	            }
// 				}).done(function(data)
// 					{  
// 					if(null != data)
// 					{
//     		 		if(data.count < 1){                        			
//     					$("#domain1Table-detail").html("<tr><td colspan='7'><span>No Data</span></td></tr>");  
//     					unloadLightBoxLoader();
//     				}else {
// 						insertdataForFirstDomain(data.count,
// 									data.data,
// 									$("#domain1 option:selected").val());
// 					}
// 					}
// 					else
// 					{
// 						unloadLightBoxLoader();
// 					}
// 					});
		}
		
		
		
		
		function populateDomain2Data(ratings,imagePath)
		{
			var domain2tableId = document.getElementById("domain2Data")
					.getElementsByTagName("TABLE");

			for ( var index = 0; index < domain2tableId.length; index++) {
				if ("dom_books" == domain2tableId[index].id
						|| "dom_movies" == domain2tableId[index].id) {

					var x = $("#" + domain2tableId[index].id).detach();
					$("#temp").prepend(x);
					break;
				}
			}

			$("#bookDetailTable").html("");
			var $tbody = $("#bookDetailTable");
			var res = new Array();
			var res_next = new Array();
			var res_next_next  = new Array();

			for ( var item = 0; item < ratings.length; (item=item+3)) {
				res = ratings[item].split(":");
				var item1 = item + 1;
				if(item1 < ratings.length)
				res_next = ratings[item1].split(":");
				var item2 = item + 2;
				if(item2 < ratings.length)
				res_next_next = ratings[item2].split(":");
				$tbody.append("<tr>"
						+ add_td_in_prefferd_domain(res[0], res[1], imagePath)
						+((item+1) < ratings.length ? add_td_in_prefferd_domain(res_next[0], res_next[1], imagePath):'')
						+((item+2) < ratings.length ? add_td_in_prefferd_domain(res_next_next[0], res_next_next[1], imagePath):'')
						+ "</tr>");
			}
					
		}
	
		$(function() {
			$('#domain1Table').tablePagination({});
			$('#domain2Data').append($("#dom_books"));
			document.getElementById("dom_books").style.display="table";
			$('#domain2Data').tablePagination({});
			
			$("#test").click(function () {
			 alert("testing")
			});
		});
		
		
		function add_td_in_second_domain(id,imagePath,divId)
		{	
			return "<td><div class='listHolder'><div class='elementImage' title='Click to flip'><div class='ImageFlip' id='"+divId+"' onclick='test("+divId+");'>" +
					"<img height=\"115\" width=\"90\" src=\"images/"+imagePath+"/"+id+".jpg\" alt=\""+id+"Image\"/></div>" +
					"<div class='ImageData'><div class='ImageDescription'>" +
					"<img height=\"115\" width=\"90\" src=\"images/"+imagePath+"/"+id+".jpg\" alt=\""+id+"Image\"/><br />" +
					"</div><div class='ImageURL'><div id='description'><b>DESCRIPTION : <br/>Description</b></div>" +
					"<br /><div id='genre' style='font-size:larger;'><b><i>GENRE : <br/>Genre</i></b></div></div></div></div></td>"; 
		}
		
		
		
		function insertdata(count, data, domain2) {
	      	
			unloadLightBoxLoader();
			if(count>0)
			{
				document.getElementById("recdata").style.visibility="visible";
				$("#rec-data-detail").html("");  
				var $tbody = $("#rec-data-detail");
				
				if(domain2 == "1")
				{
					imagePath = "movieImages";
				}
				else if(domain2 == "2")
				{
					imagePath = "bookImages";
				}

				for (var item=0;item<count;item = (item+5))
				{
					$tbody.append("<tr>"+add_td_in_second_domain(data[item].id,imagePath,item)+
							   ((item+1) < count ? add_td_in_second_domain(data[item+1].id,imagePath,(item+1)):'')+
							   ((item+2) < count ? add_td_in_second_domain(data[item+2].id,imagePath,(item+2)):'')+
							   ((item+3) < count ? add_td_in_second_domain(data[item+3].id,imagePath,(item+3)):'')+
							   ((item+4) < count ? add_td_in_second_domain(data[item+4].id,imagePath,(item+4)):'')+
								"</tr>");
				}
					
			}
		}
		

		</script>
    </head>
    
    <body>
    <div id ="temp" hidden="true">
	<table style="padding: 1em; background-color: white; border: 1px; width: 31%;" id="dom_books" hidden="true">
		<tbody id="dom_books_detail">
			<c:forEach items="${bookList}" var="rating" step="5" varStatus="index">
				<tr>
					<c:forEach var="i" begin="${index.index+1}" end="${index.index+5}" varStatus="status">
						<c:if test="${i le listSize}">
							<td><img height="115" width="90" title="Click to rate"
								src="images/bookImages/${bookList[i-1].id}.jpg"
								alt="${bookList[i-1].id} Image"
								onclick="return loadLightBox('dom_books','${bookList[i-1].id}','bookImages','${bookList[i-1].descrption}','${bookList[i-1].genre}');" /></td>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<table style="padding: 1em; background-color: white; border: 1px; width: 31%;" id="dom_movies" hidden="true">
		<tbody id="dom_movies_details">
			<c:forEach items="${movieList}" var="rating" step="5"
				varStatus="index">
				<tr>
					<c:forEach var="i" begin="${index.index+1}" end="${index.index+5}"
						varStatus="status">
						<c:if test="${i le listSize}">
							<td><img height="115" width="90" title="Click to rate"
								src="images/${imagesPath}/${movieList[i-1].id}.jpg"
								alt="${movieList[i-1].id} Image"
								onclick="return loadLightBox('dom_movies','${movieList[i-1].id}','${imagesPath}','${movieList[i-1].descrption}','${movieList[i-1].genre}');" /></td>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
</body>
</html>

