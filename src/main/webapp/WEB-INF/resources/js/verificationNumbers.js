var code ;    
function createCode(){       
    code = "";      
    var codeLength = 4;
    var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i','j','k','l','m','n','p','o','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');      
    for(var i=0;i<codeLength;i++) {
       var charIndex = Math.floor(Math.random()*61);      
      code +=selectChar[charIndex];
    }      
    if(code.length != codeLength){      
      createCode();      
    }
    /*$.session.set('validateCode', code);*/
    /*sessionStorage.setItem('validateCode', code);*/
   /* <% session.setAttribute("validateCode", code)%>*/
    /*sessionStorage.setItem('validateCode', code);*/
    /*document.cookie="validateCode"+code;*/
    showCheck(code);
}
          
function showCheck(a){
	var c = document.getElementById("myCanvas");
	var ctx = c.getContext("2d");
	ctx.clearRect(0,0,1000,1000);
	ctx.font = "80px 'Microsoft Yahei'";
	ctx.fillText(a,30,100);
	ctx.fillStyle = "white";
	validateCode(a);
}

function validateCode(v) {
	$.ajax({
		url:"user/validateCode",
		type:"GET",
		data:"validateCode="+v,
		dataType:"text",//响应的类型
		success:function(data){
			console.log(data);
		}
	});
}

function validate () {
    var inputCode = document.getElementById("J_codetext").value.toUpperCase();
    var codeToUp=code.toUpperCase();
    if(inputCode.length <=0) {
      document.getElementById("J_codetext").setAttribute("placeholder","输入验证码");
      createCode();
      return false;
    }
    else if(inputCode != codeToUp ){
      document.getElementById("J_codetext").value="";
      document.getElementById("J_codetext").setAttribute("placeholder","验证码错误");
      createCode();
      return false;
    }
    else {
      window.open(document.getElementById("J_down").getAttribute("data-link"));
      document.getElementById("J_codetext").value="";
      createCode();
      return true;
    }

}