
(function($) {
	$('.ckeditor').ckeditor({
  // optional config
	});
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

	$(document).on("click", ".session_start", function() {
		$( "#session_start" ).trigger('click');
		return false;
		e.preventDefault();
	});

	$(document).on("click", "#change-portrait", function() {
		$( "#change-portrait" ).hide('slow');
		$("#update-portrait").show('slow');
		return false;
		e.preventDefault();
	});

	

})( jQuery );

$(document).ready(function(){
	uploadBtn = document.getElementById("uploadBtn")
	if(uploadBtn) {
	 document.getElementById("uploadBtn").onchange = function () {
		    document.getElementById("uploadFile").value = this.value;
		};
	}

	// for addthis - dynamic loading of content
	addthis.init();
	

});


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


