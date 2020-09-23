$(document).ready(function () {
    document.getElementById("id").focus();
});


$(document).on("click", "#pwHidden", function(){
    if ($("#pwHidden").attr("class") == "fa fa-eye fa-lg") {
        $("#pwHidden").attr("class", "fa fa-eye-slash fa-lg");
        $("#pw").attr("type", "password");
    } else {
        $("#pwHidden").attr("class", "fa fa-eye fa-lg");
        $("#pw").attr("type", "text");
    }
});

$(document).on("click", "#login-button", function(){
    if($("#id").val() != ""){
        if($("#pw").val() != ""){
            var query = {
                id : $("#id").val(),
                pw : $("#pw").val()
            }
            $.ajax({
                type: "post",
                url: "/member/postLogin",
                data: query,
                success: function(login){
                    loginCheck(login);
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:"
                       + request.responseText + "\n" + "error:" + error);
                 }
            });
        } else{
            $("#pw").focus();
        }
    } else{
        $("#id").focus();
    }
});

$(document).on("keypress", "#pw", function (e) {
    if (e.which == 13) {
       $("#login-button").click();
    }
 });

function loginCheck(login) {
    switch (login) {
        case "success":
            $("#f").submit();
            break;
        case "idFalse":
            alert("아이디가 존재하지 않습니다.");
            $("#id").val("");
            $("#pw").val("");
            $("#id").focus();
            break;
        default:
            alert("비밀번호가 다릅니다.");
            $("#pw").val("");
            $("#pw").focus();
            break;
    }
}