var regTypeID = /[^a-z0-9]/gi;
// var regTypePW = /^[a-zA-Z0-9](?=.*[!@#$%^*+=-]){8,}/;
var regTypePW = /^(?=.*[a-zA-Z])(?=.*[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\#$%&\\\=\(\'\"])(?=.*[0-9]).{8,}/;
var regTypeNickname = /[^a-z0-9ㄱ-ㅎ가-힣0-9]/gi;
var submitFlag = true;

$(document).on("click", "#bBack", function () {
    location.href = "/member/fRegister";
});

$(document).on("click", "#bNext", function () {
    if(submitFlag){
        submitFlag = false;
        checkNickname();
    }
});

function checkNickname() {
    if ($("#nicknameMsg").val() != "check") {
        submitFlag = true;
        alert("닉네임 중복 확인해주세요");
        nickname.focus();
        return;
    }
    checkID();
}

function checkID() {
    if ($("#idMsg").val() != "check") {
        submitFlag = true;
        alert("아이디 중복 확인해주세요");
        id.focus();
        return;
    }
    checkEmail();
}

function checkEmail() {
    if ($("#email").val().trim() != "" && $("#email2").val().trim() != "") {
        $("#mEmail").val($("#email").val().trim() + "@" + $("#email2").val().trim());
    } else {
        alert("이메일을 입력해주세요");
        submitFlag = true;
        email.focus();
        return;
    }
    checkPW();
}

function checkPW() {
    if ($("#pw").val() != "") {
        if ($("#pw").val().length != $("#pw").val().trim().length) {
            submitFlag = true;
            alert("비밀번호는 공백으로 시작하거나 공백으로 끝날 수 없습니다.");
            return;
        }
        if (regTypePW.test($("#pw").val())) {
            if ($("#pwRepeat").val() != $("#pw").val()) {
                submitFlag = true;
                alert("비밀번호가 다릅니다.");
                pwRepeat.focus();
                return;
            }
        } else {
            alert("비밀번호 양식을 맞춰주세요.");
            submitFlag = true;
            return;
        }
    } else {
        alert("비밀번호를 입력해주세요");
        submitFlag = true;
        pw.focus();
        return;
    }
    $("#f").submit();
}

$(document).on("keyup", "#nickname", function () {
    var v = this.value;
    this.value = v.replace(regTypeNickname, "");
    $("#nickname").val($("#nickname").val().substr(0,8));
});

$(document).on("keydown", "#nickname", function () {
    $("#nicknameMsg").val("");
    $("#nicknameMsg").text("");
});

$(document).on("keyup", "#id", function () {
    var v = this.value;
    this.value = v.replace(regTypeID, "");
});

$(document).on("keydown", "#id", function () {
    $("#idMsg").val("");
    $("#idMsg").text("");
});

$(document).on("keyup", "#pw", function () {
    if (regTypePW.test($("#pw").val())) {
        $(document).on("keyup", "#pwRepeat", function () {
            if ($("#pwRepeat").val() == $("#pw").val()) {
                $("#pwConfirm").text("비밀번호 일치");
            } else {
                $("#pwConfirm").text("비밀번호 불일치");
            }
        });
    } else {
        $("#pwConfirm").text("");
    }
});

$(document).on("click", "#pwHidden", function () {
    if ($("#pwHidden").attr("class") == "fa fa-eye fa-lg") {
        $("#pwHidden").attr("class", "fa fa-eye-slash fa-lg");
        $("#pw").attr("type", "password");
        $("#pwHidden").attr("type", "password");
    } else {
        $("#pwHidden").attr("class", "fa fa-eye fa-lg");
        $("#pw").attr("type", "text");
        $("#pwHidden").attr("type", "text");
    }
});

$(document).on("click", "#idCheck", function () {
    if ($("#id").val().trim() != "") {
        var query = {
            mID: $("#id").val()
        };
        $.ajax({
            url: "/member/idCheck",
            type: "post",
            data: query,
            success: function (data) {
                if (data == 1) {
                    $("#idMsg").text("이미 중복된 아이디입니다.");
                    $("#idMsg").val("");
                } else {
                    $("#idMsg").text("사용이 가능합니다");
                    $("#idMsg").val("check");
                }
            }
        });
    } else {
        alert("아이디를 입력해주세요");
    }
});

$(document).on("click", "#nicknameCheck", function () {
    if ($("#nickname").val().trim() != "") {
        if($("#nickname").val().length <= 8) {
        var query = {
            mNickname: $("#nickname").val()
        };
        $.ajax({
            url: "/member/nicknameCheck",
            type: "post",
            data: query,
            success: function (data) {
                if (data == 1) {
                    $("#nicknameMsg").text("이미 중복된 닉네임입니다.");
                    $("#nicknameMsg").val("");
                } else {
                    $("#nicknameMsg").text("사용이 가능합니다");
                    $("#nicknameMsg").val("check");
                }
            }
        });
    } else{
        alert("닉네임은 8자 이하로 가능합니다.");
    }
 } else {
        alert("닉네임을 입력해주세요");
    }
});

/* 옵션에서 이메일 값 불러오기*/
$(document).on("change", "#emailSelection", function () {
    $('#email2').val($(this).val());
});