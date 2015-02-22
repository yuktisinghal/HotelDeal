<%@page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" session="false"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!doctype html>

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Hotel TV Web Application</title>
<link rel="stylesheet" type="text/css"
	href="css/common/headerFooter.css" />
<link rel="stylesheet" href="css/rateit.css" type="text/css"
	media="screen" title="Rating CSS">
<link rel="stylesheet" href="css/pagination.css" type="text/css"
	media="screen" title="Pagination">
<link rel="stylesheet" href="css/style.css" type="text/css"
	media="screen" title="">
<link rel="stylesheet" href="css/flipImage.css" type="text/css"
	media="screen" title="">
<link rel="stylesheet" href="css/jquery-ui/jquery-ui.css" type="text/css"
	media="screen" title="">
<link rel="stylesheet" href="css/jquery-ui/jquery-ui.css" type="text/css"
	media="screen" title="">
<link rel="stylesheet" href="css/jquery.multiselect.css" type="text/css"
	media="screen" title="">
<link rel="stylesheet" href="css/jquery.dataTables.css" type="text/css"
	media="screen" title="">

<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>

 

<script type="text/javascript" src="js/jquery-ui/jquery-ui-1.10.4.min.js"></script>
<script src="http://cdn.datatables.net/1.10.5/js/jquery.dataTables.min.js"></script>

<script type="text/javascript" src="js/tablePagination.js"></script>
<script type="text/javascript" src="js/tableUpdatedPagination.js"></script>

<script type="text/javascript" src="js/script.js"></script>

<script type="text/javascript">
$(document).ready(function() {
    // Setup - add a text input to each footer cell
    $('#hotelDealTable tfoot th').each( function () {
        var title = $('#hotelDealTable thead th').eq( $(this).index() ).text();
        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
    } );
 
    // DataTable
    var table = $('#hotelDealTable').DataTable();
 
    // Apply the search
    table.columns().eq( 0 ).each( function ( colIdx ) {
        $( 'input', table.column( colIdx ).footer() ).on( 'keyup change', function () {
            table
                .column( colIdx )
                .search( this.value )
                .draw();
        } );
    } );
    
    $("#txtFromDate").datepicker({
        minDate: 0,
        maxDate: "+60D",
        numberOfMonths: 2,
        onSelect: function(selected) {
          $("#txtToDate").datepicker("option","minDate", selected)
        }
    });
    $("#txtToDate").datepicker({ 
        minDate: 0,
        maxDate:"+60D",
        numberOfMonths: 2,
        onSelect: function(selected) {
           $("#txtFromDate").datepicker("option","maxDate", selected)
        }
    });
    
    
} );


</script>
</head>


<body onload="javascript:initializeLabels();">
	<div id="pageContainer">
		<header id="pageHeader">
			<%@include file="common/header.jsp"%>
		</header>
		<div id="date">
		CheckInDate: <input type="text" id="txtFromDate" />
        CheckOutDate: <input type="text" id="txtToDate" />
		</div>
		
		<table>
			<c:if test="${not empty hotelDealsList}">
    		<table id="hotelDealTable" style="width:80%;height: 20% ">
    			<thead>
            	<tr>
                <th>Name</th>
                <th>Destination</th>
                <th>Base Rate</th>
                <th>Offer</th>
                <th>Rating</th>
                 <th>checkInDate</th>
                <th>checkOutDate</th>
                <th>Image</th>
       			</tr>
        	</thead>
         	<tfoot>
            	<tr>
               	<th>Name</th>
                <th>Destination</th>
                   <th>Base Rate</th>
                <th>Offer</th>
                <th>Rating</th>
                 <th>checkInDate</th>
                  <th>checkOutDate</th>
                <th>Image</th>
            	</tr>
        	</tfoot>
        	<tbody id="hotelDetilsList">
        		<c:forEach var="o" items="${hotelDealsList}">
            	<tr>
	                <td>${o.name}</td>
    	            <td>${o.longDestinationName}</td>
    	           
        	        <td>${o.baseRate} + ${o.taxesAndFees} ${o.currency}</td>   
        	        <td>${o.promotionDescription}</td>  
        	        <td>${o.starRating}</td>
        	        <td>${o.checkInDate}</td>
        	        <td>${o.checkOutDate}</td>        	        
        	        <td><img src="${o.imageUrl}"/></td>  
        	        
            	</tr>
        		</c:forEach>
        	</tbody>
    		</table>
			</c:if>
		</table>
		<div class="push"></div>
		

		<div id="footer">
			<%@include file="common/footer.jsp"%>
		</div>
	</div>

</body>
</html>

