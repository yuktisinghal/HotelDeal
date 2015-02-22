<%@page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" session="false"%>
<%@page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!doctype html>

<html lang="en">
    <head>
    	
		<script type="text/javascript">
		
		var ratings = new Array();
		var serversRatings = new Array();
		var prefferedBooksRating = new Array();
		var prefferedMovieRating = new Array();
		
		function rateMovie(id,rating,genre,description){
			ratings.push(id+":"+rating+":"+genre+":"+description);
			serversRatings.push(id+":"+rating+":"+genre);
		}
		
		function getRecommendations()
		{
			checkForDomain();
			loadLightBoxLoader();
			if(serversRatings.length == 0)
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
							+"ratings="+serversRatings+"&selectedFirstDomain="+$("#domain1 option:selected").val()+
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
    						prefferedBooksRating = [];
    						prefferedMovieRating = [];
    					}else {
							insertdata(data.count,
									data.data,
									$("#domain2 option:selected").val());
						
						}
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
 
					});
		}
		
		
		function updateRatingdiv()
		{
			ratings = [];
			serversRatings = [];
		  	var domain1 = $("#domain1 option:selected").val();
		  	if(domain1 == "-1")
		  	{
		  		return;
		  	}
		  	
		  	if(1 == domain1)
		  	{
		  		$("#Label1").html("Movies");
		  		$("#recommendation").html("Recommended Books");
		  		document.getElementById('movieGenreDropDown').style.display='block';
		  		document.getElementById('bookGenreDropDown').style.display='none';
		  	}
		  	else if(2 == domain1)
		  	{
		  		$("#Label1").html("Books");
		  		$("#recommendation").html("Recommended Movies");
		  		document.getElementById('movieGenreDropDown').style.display='none';
		  		document.getElementById('bookGenreDropDown').style.display='block';
		  	}
		  	
		  	var domain1tableId = document.getElementById("first_domain1_div").getElementsByTagName("TABLE")[0].id;
		 
		    var x = $("#"+domain1tableId).detach();
		    
		    if(domain1tableId == 'dom_books' || domain1tableId == 'dom_movies' || domain1tableId == 'rated_data' || domain1tableId == 'domain1Table_data')
		    {
		    	$("#temp").prepend(x);
		    }
		    
			deleteRefreshButtons();
	      
		    if(1 == domain1)
		    {
		    	$("#first_domain1_div").append($("#dom_movies"));
		    	document.getElementById("dom_movies").style.display="table";
		    	$('#dom_movies').tablePagination({});
		    }
			else if(2 == domain1)
			{
		    	$("#first_domain1_div").append($("#dom_books"));
		    	document.getElementById("dom_books").style.display="table";
				$('#dom_books').tablePagination({});
			}
		  	
			$("#Label2").html("Rate Below");
		}
		
	
	
		function add_td_in_second_domain(id,imagePath,divId,genre,description)
		{	
			return "<td><div class='listHolder'><div class='elementImage' title='Click to flip'><div class='ImageFlip' id='"+divId+"' onclick=\"flipRecommendations('"+divId+"');\">" +
					"<img height=\"115\" width=\"90\" src=\"images/"+imagePath+"/"+id+".jpg\" alt=\""+id+"Image\"/></div>" +
					"<div class='ImageData'><div class='ImageDescription'>" +
					"<img height=\"200\" style=\"left:300px;top: 120px;\" align=\"right\" width=\"150\" src=\"images/"+imagePath+"/"+id+".jpg\" alt=\""+id+"Image\"/><br />" +
					"</div><div class='ImageURL'><div id='description' style=\"max-width:200px;max-height:140px;overflow:scroll;\"><b>DESCRIPTION : <br/>"+description+"</b></div>" +
					"<br /><div id='genre' style='font-size:larger;'><b><i>GENRE : <br/>"+genre+"</i></b></div></div></div></div></td>"; 
		}
		
	
		
		function insertdata(count, data, domain2) {
			insertRatedData($("#domain1 option:selected").val());
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
					$tbody.append("<tr>"+add_td_in_second_domain(data[item].id,imagePath,'X'+item,data[item].genre,data[item].descrption)+
							   ((item+1) < count ? add_td_in_second_domain(data[item+1].id,imagePath,'X'+(item+1),data[item+1].genre,data[item].descrption):'')+
							   ((item+2) < count ? add_td_in_second_domain(data[item+2].id,imagePath,'X'+(item+2),data[item+2].genre,data[item].descrption):'')+
							   ((item+3) < count ? add_td_in_second_domain(data[item+3].id,imagePath,'X'+(item+3),data[item+3].genre,data[item].descrption):'')+
							   ((item+4) < count ? add_td_in_second_domain(data[item+4].id,imagePath,'X'+(item+4),data[item+4].genre,data[item].descrption):'')+
								"</tr>");
				}
					
			}
			
			ratings = [];
			serversRatings = [];
		}
		

		function insertRatedData(domain)
		{
			var imagePath = "";
			
			var count = ratings.length;			
		  	var domain1tableId = document.getElementById("first_domain1_div").getElementsByTagName("TABLE")[0].id;
		  
		    var x = $("#"+domain1tableId).detach();
		    if(domain1tableId == 'dom_books' || domain1tableId == 'dom_movies' || domain1tableId == 'rated_data' || domain1tableId == 'domain1Table_data' )
		    {
		    	$("#temp").prepend(x);
		    }
			$("#first_domain1_div").html("");
		    $("#first_domain1_div").append($("#rated_data"));
		    document.getElementById("rated_data").style.display="table";
		    $("#rated_data_detail").html("");  
			var $tbody = $("#rated_data_detail");
		    
			if(count > 0)
			{
				if(domain == "1")
				{
					imagePath = "movieImages";
				}
				else if(domain == "2")
				{
					imagePath = "bookImages";
				}
				
				for (var item=0;item<count;item = (item+5))
				{
					
					$tbody.append("<tr>"+add_td_in_second_domain(ratings[item].split(":")[0],imagePath,(item+16),ratings[item].split(":")[2],ratings[item].split(":")[3])+
						   ((item+1) < count ? add_td_in_second_domain(ratings[item+1].split(":")[0],imagePath,(item+17),ratings[item+1].split(":")[2],ratings[item+1].split(":")[3]):'')+
						   ((item+2) < count ? add_td_in_second_domain(ratings[item+2].split(":")[0],imagePath,(item+18),ratings[item+2].split(":")[2],ratings[item+2].split(":")[3]):'')+
						   ((item+3) < count ? add_td_in_second_domain(ratings[item+3].split(":")[0],imagePath,(item+19),ratings[item+3].split(":")[2],ratings[item+3].split(":")[3]):'')+
						   ((item+4) < count ? add_td_in_second_domain(ratings[item+4].split(":")[0],imagePath,(item+20),ratings[item+4].split(":")[2],ratings[item+4].split(":")[3]):'')+
							"</tr>");
				}
			}
					
		}
		
		var selElementTypes = []; 
		
		function getMultipleSelectVals( id ){
				selElementTypes = [];
		        $('#'+id+' :selected').each(function(i, selected){ 
		        	selElementTypes[i] = $(selected).text(); 
		        
		        });
		}
		
		function getUserFilteredData()
		{
			$.ajax({
				type : "GET",
				contentType: "application/json",       
				dataType: "json",
				url : "${pageContext.request.contextPath}/reccontroller/api/getSelectedDataForRating?"
						+"selectedAreas[]="+selElementTypes+
						"&selectedDomain="+$("#domain1 option:selected").val(),
				cache : false,
				error: function (request, status, error) {
          		  alert(status+" _"+error+"_"+request);
  	            }
				}).done(function(data)
	 					{  
	 					if(null != data)
	 					{
	     		 		if(data.count < 1){                        			
	     					$("#domain1Table-detail").html("<tr><td colspan='7'><span>No Data</span></td></tr>");  
	     					unloadLightBoxLoader();
	     				}else {
	 						insertdataForFirstDomain(data.count,
	 									data.data,
	 									$("#domain1 option:selected").val());
	 					}
	 					}
	 					else
	 					{
	 						alert("Data is null");
	 						unloadLightBoxLoader();
	 					}
	 					});
		}
		
		  
		$(function() {
			
			$("#first_domain1_div").append($("#dom_movies"));
	    	document.getElementById("dom_movies").style.display="table";
	    	$('#dom_movies').tablePagination({});
			$("#movieGenre").multiselect({
				   header: "Choose Type of Movie",
				   close : function()
				   {
					   getMultipleSelectVals('movieGenre');
					   getUserFilteredData();
					}
					
			});
			$("#bookGenre").multiselect({
				   header: "Choose Type of Book",
				   close : function()
				   {
					   getMultipleSelectVals('bookGenre');
					   getUserFilteredData();
				   }
					
			});
			
		});
	
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
							<td>
							<div class="listHolder">
								<div class="elementImage" title="Click to flip">
									<div class="ImageFlip">
										<img height="115" width="90" title="Click to rate"
										src="images/bookImages/${bookList[i-1].id}.jpg"
										alt="${bookList[i-1].id} Image"/>
									</div>
									<div class="ImageData">
										<div class="ImageDescription">
										<b><u><h2 id="Label2">Rate Books</h2></u></b> 
										<img  height="200" align="right" style="left:300px;top: 120px;" width="150" title="Click to rate"
										src="images/bookImages/${bookList[i-1].id}.jpg"
										alt="${bookList[i-1].id} Image" />
										<br/>
										</div>
										<div class="ImageURL">
										<div id="description" style="max-width:200px;max-height:80px;overflow:scroll;"><b>DESCRIPTION : <br/>${bookList[i-1].descrption}</b></div>
										<br />
										<!-- <div id="genre" style="font-size:larger;"><b><i>GENRE : <br/>${bookList[i-1].genre}</i></b></div> -->
										</div>
									</div>
									<div class="rateit" style="display: none;" id='rateit${bookList[i-1].id}' 
										onclick="javascript:rateMovie('${bookList[i-1].id}',$('#rateit${bookList[i-1].id}').rateit('value'),'${bookList[i-1].genre}','${bookList[i-1].descrption}');">
									</div>
							</div>
							</div>											
							</td>
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
							<td>
							<div class="listHolder">
								<div class="elementImage" title="Click to flip">
									<div class="ImageFlip">
									<img height="115" width="90" title="Click to rate"
										src="images/movieImages/${movieList[i-1].id}.jpg"
										alt="${movieList[i-1].id} Image"/>
									</div>
									<div class="ImageData">
										<div class="ImageDescription">
										<b><u><h2 id="Label2">Rate Movies</h2></u></b> 
										<img  height="200" align="right" style="left:300px;top: 120px;" width="150" title="Click to rate"
										src="images/movieImages/${movieList[i-1].id}.jpg"
										alt="${movieList[i-1].id} Image" />
										<br/>
										</div>
										<div class="ImageURL">
										<div id="description" style="max-width:200px;max-height:80px;overflow:scroll;"><b>DESCRIPTION : <br/>${movieList[i-1].descrption}</b></div>
										<br />
									<!-- <div id="genre" style="font-size:larger;"><b><i>GENRE : <br/>${movieList[i-1].genre}</i></b></div> -->	
										</div>
									</div>
									<div class="rateit" style="display: none;" id='rateit${movieList[i-1].id}' 
										onclick="javascript:rateMovie('${movieList[i-1].id}',$('#rateit${movieList[i-1].id}').rateit('value'),'${movieList[i-1].genre}','${movieList[i-1].descrption}');">
									</div>
								</div>
							</div>	
							</td>
						</c:if>
					</c:forEach>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<table style="padding: 1em; background-color: white; border: 1px; width: 31%;" id="rated_data" hidden="true">
		<tbody id="rated_data_detail">
		</tbody>
	</table>
	<table style="padding: 1em; background-color: white; border: 1px; width: 31%;" id="domain1Table_data" hidden="true">
		<tbody id="domain1Table-detail">
		</tbody>
	</table>
</div>
</body>
</html>

