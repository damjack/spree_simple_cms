$(function(){
   $('.tags input[type=checkbox]').click(function(){
       if($(this).is(":checked")){
            $('#post_tag_list').val($('#post_tag_list').val() + $(this).val() + ",");
            $('label[for=' + $(this).attr("id") + ']').css("color","green");
       } else {
           $('#post_tag_list').val($('#post_tag_list').val().replace($(this).val() + ",", ""));
           $('label[for=' + $(this).attr("id") + ']').css("color","black");
       }
   });
});