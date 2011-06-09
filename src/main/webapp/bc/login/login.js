$("#name").focus();
function login() {
	var name = $("#name").val();
	var password = $("#password").val();

	// 验证参数
	if (!name || name.length == 0) {
		showMsg("帐号不能为空！");
		$("#name").focus();
		return;
	}
	if (!password || password.length == 0) {
		showMsg("密码不能为空！");
		$("#password").focus();
		return;
	}else{
		$("#password").attr("data-p",password);
	}

	showMsg("正在登录...");
	
	$.ajax({
		url : bc.root + "/doLogin",
		data : {
			name : name,
			password : hex_md5(password)//使用md5加密避免密码明文传输
		},
		type : "POST",
		dataType: "json",
		success : function(json) {
			if(json.success){
				showMsg("登录验证成功，跳转到系统主页中...");
				//登录成功跳转到主页
				window.open(bc.root + "/index" ,"_self");
			}else{
				showMsg(json.msg);
			}
		},
		error : function(json) {

		}
	});
	return false;
}

$("#loginBtn").click(login);
$(":input").keyup(function(e){
	if(e.which == 13){//按下回车键
		if(this.id=="name" && $("#password").val() == 0){
			$("#password").focus();
		}else{
			login();
		}
	}
});

function showMsg(msg) {
	// alert(msg);
	$("#msg").html(msg);
}

//for debug: 自动以管理员登录
if(bc.debug){
	$("#name").val("admin");
	$("#password").val("888888");
	//$("#loginBtn").trigger("click");
}