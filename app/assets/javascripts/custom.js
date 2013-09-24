(function($) {

	$("a.home.menu").unbind().click(function(){
		if($("#access:visible").length == 0){
			$("#access").slideDown();
		}else{
			$("#access").slideUp();
		}
		return false;
	});
	
	

	
	// Scroll back to top
	$('#btop').click(function(){
		$.smoothScroll({
			scrollTarget: '.logo',
			 speed: 1000
		});
		return false;
		e.preventDefault();
	});
	// Conditional display	
	$(window).scroll(function () {
		if ($(this).scrollTop() > 400) {
			$('#btop').fadeIn('slow');
		} else {
			$('#btop').fadeOut('slow');
		}
	});
	
	
})( jQuery );
