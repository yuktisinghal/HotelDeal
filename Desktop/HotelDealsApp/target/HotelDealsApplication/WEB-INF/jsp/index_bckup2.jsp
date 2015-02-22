<%@page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" session="false"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!doctype html>

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Recommendation Web Application</title>
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
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-ui/jquery-ui-1.10.4.min.js"></script>
<script type="text/javascript" src="js/jquery.rateit.js"></script>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/tablePagination.js"></script>
<script type="text/javascript" src="js/tableUpdatedPagination.js"></script>
<script type="text/javascript" src="js/jquery.flip.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<%@include file="serverInterface.jsp"%>
</head>


<body onload="javascript:initializeLabels();">
	<div id="pageContainer">
		<header id="pageHeader">
			<%@include file="common/header.jsp"%>
		</header>
		<table>

			<tr>
				<td>
					<div class="dropdown">
						<select id="algo" name="algo" class="dropdown-select"
							onchange="javascript:getRecDataOnChange();">
							<c:forEach items="${algoList}" var="algo">
								<c:if test="${algoList!=null}">in
							<option value="${algo.key}">${algo.value}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</td>
				<td>
					<div class="dropdown">
						<select id="domain1" name="Domain1" class="dropdown-select"
							onclick="javascript:updateRatingdiv();">
							<c:forEach items="${domainList}" var="domain">
								<c:if test="${domainList!=null}">in
							<option value="${domain.key}">${domain.value}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</td>


				<td>
					<div class="dropdown">
						<select id="domain2" name="Domain2" class="dropdown-select"
							onclick="javascript:updateRecommendationLabel();">
							<c:forEach items="${domainList}" var="domain">
								<c:if test="${domainList!=null}">in
							<option value="${domain.key}">${domain.value}</option>
								</c:if>
							</c:forEach>
						</select>
					</div>
				</td>
			</tr>


		</table>

		<div class="body row ">

<!-- 			<div id="lightbox" -->
<!-- 				style="background: none; z-index: 100; position: absolute; display: none; top: 200px; left: 540px;"> -->
<!-- 				<div -->
<!-- 					style="height: 390px; width: 370px; background-color: white; padding: 1px;"> -->
<!-- 					<b><u><h2 id="Label2"></h2></u></b> -->
<!-- 					<table style="padding: 1em;"> -->
<!-- 						<tr> -->
<!-- 							<td><img height="250" width="200" src="" alt="1 Image" -->
<!-- 								id="popUpImage" /></td> -->
<!-- 							<td> -->
<!-- 								<div class="rateit" id='rateit' -->
<!-- 									onclick="javascript:rateMovie(lightbox,1,($('#rateit1').rateit('value')));"></div> -->
<!-- 								<br /> -->
<!-- 								<div id="description"></div> -->
<!-- 								<br /> -->
<!-- 								<div id="genre"></div> -->
<!-- 							</td> -->
<!-- 						</tr> -->
<!-- 					</table> -->
<!-- 				</div> -->
<!-- 			</div> -->


			<div id="overLay"
				style="position: fixed; height: 100%; width: 100%; background: #000; opacity: 0.6; top: 0px; left: 0px; display: none;"
				onclick="unloadLightBox();"></div>

			<div style="float: left; width: 34%; height: 70%;">
				<h2 style="background-color: white; width: 300px;" id="Label1">Movies</h2>
				<div style="height: 550px;" id="first_domain1_div">
					<table style="padding: 1em; background-color: white; width: 33%;" id="domain1Table">
						<tbody id="domain1Table-detail">
							<c:forEach items="${movieList}" var="rating" step="5" varStatus="index">
								<tr>
									<c:forEach var="i" begin="${index.index+1}" end="${index.index+5}" varStatus="status">
										<c:if test="${i le listSize}">
											<td>
												<div class="listHolder">
													<div class="elementImage" title="Click to flip">
														<div class="ImageFlip">
															<img height="115" width="90" title="Click to rate" src="images/${imagesPath}/${movieList[i-1].id}.jpg"
																alt="${movieList[i-1].id} Image" />
														</div>
														<div class="ImageData">
															<div class="ImageDescription">
																<b><u><h2 id="Label2">Rate Movies</h2></u></b> 
																<img height="200" align="right" style="left:200px;top: 120px;" width="150" title="Click to rate"
																	src="images/${imagesPath}/${movieList[i-1].id}.jpg"
																	alt="${movieList[i-1].id} Image"/>
																<br />
															</div>
															<div class="ImageURL">
															<div id="description"><b>DESCRIPTION : <br/>${movieList[i-1].descrption}</b></div>
																<br />
															<div id="genre" style="font-size:larger;"><b><i>GENRE : <br/>${movieList[i-1].genre}</i></b></div>
														</div>
														</div>
															<div class="rateit" style="display: none;" id='rateit${movieList[i-1].id}' 
															 onclick="javascript:rateMovie(lightbox,${movieList[i-1].id},$('#rateit${movieList[i-1].id}').rateit('value'));"></div>
														</div>
												  </div>
											</td>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div id="lightBoxLoad"
					style="background: none; z-index: 100; position: absolute; display: none; top: 50%; left: 45%;">
					<img src='images/loading.gif'
						style="background-image: none; align: center" />
				</div>

				<br /> <br />
			</div>
<!-- 			<div style="float: left; width: 31%; height: 70%"> -->
<!-- 				<h2 style="background-color: white; width: 300px;" id="Label3">Books</h2> -->

<!-- 				<div style="height: 550px;" id="domain2Data"> -->
<!-- 					<table id="bookDetailTable" -->
<!-- 						style="padding: 1em; background-color: white;"> -->
<!-- 					</table> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div style="float: right; height: 70%; width: 31%">
				<div align="left">
					<h2 style="background-color: white; width: 300px"
						id="recommendation">Recommend Books</h2>
					<div class="dropdown_small">
						<select id="numOfRec" name="numOfRec" class="dropdown-select"
							onchange="javascript:getRecDataOnChange();"
							title="Select number of top most recommendations to recieve">
							<option value="15">15</option>
							<option value="5">5</option>
							<option value="10">10</option>
						</select>
					</div>
				</div>

				<div style="height: 550px; visibility:hidden;" id="recdata">
					<table id="rec-detail-table"
						style="padding: 1em; width: 33%; background-color: white;">
						<tbody id="rec-data-detail">
						</tbody>
					</table>
				</div>
			</div>


			<div class="footer row">
				<%@include file="common/footer.jsp"%>
			</div>
		</div>
	</div>

</body>
</html>

