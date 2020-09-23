
$(document).on("click", "#bBack", function () {
    location.href = "/member/login";
});


$(document).on("click", "#bNext", function () {
    if ($("#ch1").prop("checked")) {
        if ($("#ch1").prop("checked")) {
            if ($("#ch1").prop("checked")) {
                $("#f").submit();
            } else {
                alert("위치 정보 동의");
            }
        } else {
            alert("개인정보 수집 및 이용 동의");
        }
    } else {
        alert("이용약관 동의");
    }
});

$(document).on("click", "#ch4", function(){
    if($(this).prop("checked")){
        $("input:checkbox").prop("checked", true);
    } else{
        $("input:checkbox").prop("checked", false);
    }
});
