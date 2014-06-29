$(document).ready(function(){
	$("#answer_reply_form_container").hide();
});

$(function () {
    $('#answer_btn').click(function(){
			$("#answer_form_container").show();
			$("#answer_btn").hide();
    });
		$(".reply_btn").on("click", function(e){
        e.preventDefault();
        var href = $(this).attr('value');
        $("#answer_reply_form_container").show();
				$(this).hide();
				$("#answer_reply_form_container form").attr('action','answers/' +href + '/reply');
        return false;
    });
});
