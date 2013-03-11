//= require ckeditor/init

(function($){
	$(document).ready(function(){

		if($('#contact_form').is('*')) {

			$('#contact_form').validate();
			$("label.error").each(function() {
				$(this).parent("div.s_row_2").addClass("s_error_row");
			});
		}
	});
})(jQuery);