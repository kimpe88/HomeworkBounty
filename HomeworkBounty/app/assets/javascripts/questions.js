$(document).ready(function(){
	$("#answer_reply_form_container").hide();
});

$(function () {
    $('#answer_btn').click(function(){
			$("#answer_reply_form_container").hide();
			$("#answer_form_container").show();
			scroll_to_element($("#answer_form_container"))
    });
		$(".reply_btn").on("click", function(e){
				$("#answer_form_container").hide();
        e.preventDefault();
        var href = $(this).attr('value');
        $("#answer_reply_form_container").show();
				$("#answer_reply_form_container form").attr('action','/answers/' + href + '/replies');
				scroll_to_element($("#answer_reply_form_container"))
        return false;
    });
});
function scroll_to_element(target){
	  $('html, body').animate({
			scrollTop: target.offset().top
    }, 1000);
}