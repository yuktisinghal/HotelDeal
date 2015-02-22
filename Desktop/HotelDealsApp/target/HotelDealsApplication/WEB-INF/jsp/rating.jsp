<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>rating test</title>

<link rel="stylesheet" href="css/rateit.css" type="text/css"
	media="screen" title="Rating CSS">

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.rateit.js"></script>



</head>

<body>


            <div class="rateit" id="rateit9">
            </div>
            <div>
                <button onclick="alert($('#rateit9').rateit('value'))">
                    Get value</button>
                <button onclick="$('#rateit9').rateit('value',prompt('Input numerical value'))">
                    Set value</button>
            </div>
      
    
	<!-- 	<section class="container"> -->
	<!-- 		<input type="radio" name="example" class="rating" value="1" /> <input -->
	<!-- 			type="radio" name="example" class="rating" value="2" /> <input -->
	<!-- 			type="radio" name="example" class="rating" value="3" /> <input -->
	<!-- 			type="radio" name="example" class="rating" value="4" /> <input -->
	<!-- 			type="radio" name="example" class="rating" value="5" /> -->
	<!-- 	</section> -->




</body>
</html>
