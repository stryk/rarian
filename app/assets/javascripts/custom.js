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


//$(document).ready(function(){
//  $('.input-required').each(function(){
//    $(this).closest('label').after("<em>*</em>");
//  });
//})

})( jQuery );

function toggle_visibility_from_hidden(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'block')
          e.style.display = 'none';
       else
          e.style.display = 'block';
};

function toggle_visibility_from_visible(id) {
       var e = document.getElementById(id);
       if(e.style.display == 'none')
          e.style.display = 'block';
       else
          e.style.display = 'none';
};