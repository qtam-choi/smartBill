<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<jsp:include  page="./include/header.jsp" flush="true"/>
<script type="text/javascript">

	function fnAdminLogin() {
		var user_id = $("#user_id").val();
		var passwd = $("#passwd").val();
		
		if(user_id == ""){
			alert("아이디를 입력하여 주십시오.");
			$("#user_id").focus();
			return;
		}else if(passwd == ""){
			alert("비밀번호를 입력하여 주십시오.");
			$("#passwd").focus();
			return;
		}
		
		var dataArr = getFormData($("#form1")) 
		
		$.ajax({
		    type : "POST" 
		    , async : true
		    , url : "loginAction.do"
		    , dataType : "json"
		    , data : dataArr
		    , error : function(request, status, error) {
		    	alert("처리 중 오류가 발생하였습니다.");
		    }
		    , success : function(data) {
		    	
		    	if(data.RETURN_CODE == "E"){
	    			alert(data.RETURN_MSG);
	    			if(data.LOCATION != null){
	    				location.replace(data.LOCATION);
	    			}
	    			return;
		    	}else{
		    		location.replace("main.do");
			    }
		    }
		});   
	}
	
	
	$(document).ready(function() {
		
		//alert($("#user_id").val());
		
		if($("#user_id").val() == ""){
			$("#user_id").focus();	
		}else{
			$("#passwd").focus();	
		}
		
			
	});
	
</script>



    </head>
    <body>
        <div id="Wrap" class="Loginbg">
            <ul>
                <li><img src="<c:url value='/images/kftc_logo.png'/>" alt="KISA 한국인터넷진흥원" width="300" height="48"></li>
                <li><img src="<c:url value='/images/kt_logo.png'/>" alt="KT" width="59" height="48"></li>
            </ul>
            <form name="form1" id="form1" style="margin:0;">  
	            <div class="LoginWrap" style="height:220px;">
	                <h2>스마트 전자영수증 시스템</h2>
	                <input type="text" class="logininput mb5 mt10" id="user_id" name="user_id" placeholder="아이디">
	                <input type="password" class="logininput mb10" id="passwd"  name="passwd"   placeholder="비밀번호" onkeydown="javascript:if(event.keyCode==13 && this.value==''){fnAdminLogin(); return false;}else if(event.keyCode==13 && this.value !=''){fnAdminLogin();}">
	                <div class="mid-line"></div>
	                <!-- input type="text" class="logininput mb5" placeholder="휴대폰번호 '-'없이 입력" style="width:150px; float:left">
	                <div type="button" class="loginbtn tel-num" onclick="alert('휴대폰 인증번호를 받습니다.');">인증번호받기</div>
	                <input type="text" class="logininput mb10" placeholder="문자입력">
	                <img src="'/images/capcha.jpg" alt=" " class="capcha">
	                <input type="text" class="logininput mb5" placeholder="캡챠문자 입력" -->
	                <button type="button" class="loginbtn mb10" onclick="fnAdminLogin();" style="height:60px;">
	                    <img src="<c:url value='/images/icon_login2.png'/>" alt="login" width="20" height="20" style="margin-right:10px;">LOGIN</button>
	            </div>
            </form>
            <!--login end-->
        </div>
        <div class="logincopy" style="bottom:25px;margin-left: -190px;width:350px;width:350px;font-size:15px;font-weight:bold;color:#1E2740">© 2019 ATON Consortium All rights reserved.</div>
    </body>
</html>