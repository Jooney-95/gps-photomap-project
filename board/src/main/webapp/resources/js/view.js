function imgList(i) {
    if(i == 1){
       $(".gallery" ).css("display", "");
        $(".original" ).css("display", "none");
        $(".type1").css('border-bottom','1px solid #7f7e7e');
       $(".type2").css('border-bottom','1px solid #f2f0f0');
       $("#gg").css('color','#7f7e7e');
       $("#ll").css('color','#ccc');
      
    } else{
         $(".original" ).css("display", "");   
          $(".gallery").css("display", "none");
          $(".type2").css('border-bottom','1px solid #7f7e7e');
         $(".type1").css('border-bottom','1px solid #f2f0f0');
         $("#ll").css('color','#7f7e7e');
         $("#gg").css('color','#ccc');
    }
     
 }