$(document).ready(function(){
	/* The following code is executed once the DOM is loaded */
	
	$('.ImageFlip').bind("click",function(){
		
		// $(this) point to the clicked .ImageFlip element (caching it in elem for speed):
		var elem = $(this);
		// data('flipped') is a flag we set when we flip the element:
		
		if(elem.data('flipped'))
		{	
			// If the element has already been flipped, use the revertFlip method
			// defined by the plug-in to revert to the default state automatically:
			elem.revertFlip();
			elem.height('70%');
			elem.width('70%');
			elem.siblings('.rateit').css('display', 'none'); 
			elem.css('z-index',10);
			// Unsetting the flag:
			elem.data('flipped',false);
		}
		else
		{
			// Using the flip method defined by the plugin:
			
			elem.flip({
				direction:'lr',
				speed: 350,
				onBefore: function(){
					// Insert the contents of the .sponsorData div (hidden from view with display:none)
					// into the clicked .ImageFlip div before the flipping animation starts:
					elem.html(elem.siblings('.ImageData').html());
					elem.height('310px');
					elem.width('400px');
					elem.css('z-index',200);
					elem.siblings('.rateit').css('display', 'block'); 
					
				}
			});
			
			// Setting the flag:
			elem.data('flipped',true);
		}
	});
	
});


function flipRecommendations(id)
{
	var elem = $('#'+id);

	if(elem.data('flipped'))
	{	
		// If the element has already been flipped, use the revertFlip method
		// defined by the plug-in to revert to the default state automatically:
		elem.revertFlip();
		elem.height('70%');
		elem.width('70%');
		elem.siblings('.rateit').css('display', 'none'); 
		elem.css('z-index',10);
		// Unsetting the flag:
		elem.data('flipped',false);
	}
	else
	{
		// Using the flip method defined by the plugin:
		elem.flip({
			direction:'lr',
			speed: 350,
			onBefore: function(){
				// Insert the contents of the .sponsorData div (hidden from view with display:none)
				// into the clicked .ImageFlip div before the flipping animation starts:
				elem.html(elem.siblings('.ImageData').html());
				elem.height('310px');
				elem.width('400px');
				elem.css('z-index',200);
				elem.siblings('.rateit').css('display', 'block'); 
				
			}
		});
		
		// Setting the flag:
		elem.data('flipped',true);
		
	}
	
}