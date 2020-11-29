<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<jsp:include  page="../include/header.jsp" flush="true"/>
<script type="text/javascript">
	
	function isValidateHP(str){
		if(str.substr(0,2) != "01"){
			return false;
		}
		
		if(!(str.length == 11)){
			return false;
		}
		
	   return true;	
	}


	function checkPassword(id,password){
		
		if(password.indexOf("$") > 0){
			alert('"$"는 제외해주세요. ');
			return false;
		}
	
		if(! /^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#%^&+=]).*$/.test(password)){
			alert('숫자와 영문자 특수문자($ 제외) 조합으로 8~16자리를 사용해야 합니다.');
			return false;
		}
	
		var checkNumber = password.search(/[0-9]/g);
		var checkEnglish = password.search(/[a-z]/ig);
	
		if(checkNumber <0 || checkEnglish <0){
			alert("숫자와 영문자를 혼용하여야 합니다.");
			return false;
		}
	
		if(/(\w)\1\1\1/.test(password)){
			alert('444같은 문자를 4번 이상 사용하실 수 없습니다.');
			return false;
		}
	
		if(password.search(id) > -1){
			alert("비밀번호에 아이디가 포함되었습니다.");
			return false;
	
		}
	
		return true;
	
	}


	
	function db_action(act)
    {	
		
		var f = document.form1;
		
		
		if(act == 'INSERT'){
			
			if(f.userid.value== ""){
				alert('ID를 입력하세요..');
				f.userid.focus();
				return;
			}
			
			if(f.id_chk.value== ""){
				alert('ID 중복체크를 하세요.');
				return;
			}
			
			if(f.passwd.value== ""){
				alert('패스워드를  입력하세요..');
				f.passwd.focus();
				return;
			}
			
			
			//UPDATE
			if(checkPassword($("#userid").val(), $("#passwd").val()) == false){
				$("#passwd").focus();
				return;
			}
			
			
			if($("#passwd").val() != $("#repasswd").val()){
				alert('두 비밀번호가 일치하지 않습니다. \n다시확인하세요.')
				return;
			}
			
		
			if(f.usernm.value== ""){
				alert('이름을 입력하세요.');
				f.usernm.focus();
				return;
			}
			
			
			
			if($("#email").val() == ""){
				
				alert('이메일을 입력하세요.'); 	
				$("#email").focus();
				return;
				 
			}
			
			if(!CheckEmail(f.email.value)){
				alert('이메일 형식이 아닙니다.');
				f.order_email.focus();
				return;
				
			}
			

			if($("#tel").val() == ""){
				
				alert('휴대폰번호를 입력하세요.'); 	
				$("#tel").focus();
				return;
				 
			}
			
			if(!isValidateHP($("#tel").val())){
				alert("휴대폰 번호가 잘못되었습니다. 확인하세요."); 	
				$("#tel").focus();
				return;
			}
			
			
			if($("#auth").val() == ""){
				
				alert('권한을 선택하세요.'); 	
				$("#auth").focus();
				return;
				 
			}
			

			
		}else if(act == 'ID_CHECK'){
			
			if(f.userid.value== ""){
				alert('ID를 입력하세요..');
				f.userid.focus();
				return;
			}
		}

		
    	var dataArr = getFormData($("#form1")); 
    	dataArr.action = act;
    	 
    	$.ajax({
    	    type : "POST" 
    	    , async : true
    	    , url : "menu0301Action.do"
    	    , dataType : "json"
    	    , data : dataArr
    	    , traditional: true
    	    , beforeSend: function() {
    	    	$.blockUI({ message: '<h1><br/><img src="<c:url value='/images/busy.gif'/>" width="20"/>&nbsp;&nbsp작업 중<br/><br/>' }); 
    	    }
    	    , error : function(request, status, error) {
    	    	$.unblockUI();
    	    	alert("처리 중 오류가 발생하였습니다.");
    	    }
    	    , success : function(data) {
    	    	
    	    	$.unblockUI();
    	    	
    	    	if(data.RETURN_CODE == "E"){
        			alert(data.RETURN_MSG);
        			if(data.LOCATION != null){
        				location.replace(data.LOCATION);
        			}
        			return;
    	    	}else{
    	    		
					if(act == 'ID_CHECK'){
			    		
			    		if(data.IDCHK == "true"){
			    			alert("사용할 수 있는 ID 입니다.");
			    			$("#userid").attr("readOnly", true);
			    			$("#chk_btn").hide();
			    			$("#id_chk").val("ok");
			    			
			    			
			    		}else{
			    			alert("이미 존재하는 ID 입니다.");
			    			$("#user_").focus();
			    			
			    		}
	
			    	}else if(act == 'INSERT'){
			    		alert('등록되었습니다.');
	    	    		location.replace("menu0301.do");
			    	}
    	    		
    	    		
    		    }
    	    }
    	});     
    }
	

</script>

</head>
<body>
        <div id="Wrap">

			<jsp:include  page="../include/top.jsp" flush="true"/>
            
            <!-- section start -->
            <section class="fclear">

                <jsp:include  page="../include/left.jsp" flush="true"/>
                
                <!--ContentWrap start-->
                <div
                    class="ContentWrap">
                    <!--title nav start-->
                    <h2>사용자 관리</h2>
                    <div class="nav">
                        <img src="<c:url value='/images/icon_home.png'/>" alt="home"><span><img src="<c:url value='/images/icon_nav.png'/>" alt="step">
                            사용자 관리</span>
                        <img src="<c:url value='/images/icon_nav.png'/>" alt="step"><span>
                            <strong>사용자 등록</strong>
                        </span>
                    </div>
                    <!--title nav end-->
                    <!--contents start-->
                    <div class="contents">
                        <h3 class="mt30">사용자 등록</h3>
                        
                        <form name="form1" id="form1"  method="POST" >
						<input type="hidden" name="id_chk" id="id_chk" value="">
						<input type="hidden" name="attribute1" id="attribute1" value="">
                        
                        
                        <table class="BasicTbl2 mt30">
                            <colgroup>
                                <col width="13%">
                                <col width="*">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>
                                        <span class="star">*</span>아이디</th>
                                    <td>
                                        <input type="text" class="input6" placeholder="" style="width:160px;" name="userid" id="userid" maxlength="20">
                                        <button type="button" class="btn1 bggrey" onclick="db_action('ID_CHECK')"  id="chk_btn">중복확인</button>
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <span class="star">*</span>비밀번호</th>
                                    <td>
                                        <input type="password" class="input6" placeholder="" style="width:160px;" name="passwd" id="passwd"  maxlength="16">
                                        ※ 8~16자리로 숫자와 영문자 특수문자를 포함하여 설정
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <span class="star">*</span>비밀번호 확인</th>
                                    <td>
                                        <input type="password" class="input6" placeholder="" style="width:160px;" name="repasswd" id="repasswd"  maxlength="16">
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <span class="star">*</span>이 름</th>
                                    <td>
                                        <input type="text" class="input6" placeholder="" style="width:160px;"  name="usernm" id="usernm"  maxlength="10">
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <span class="star">*</span>이메일</th>
                                    <td>
                                        <input type="text" class="input6" placeholder="" style="width:160px;" name="email" id="email"  maxlength="30">
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <span class="star">*</span>연락처(H.P)</th>
                                    <td>
                                        <input type="text" class="input6" placeholder="" style="width:160px;" name="tel" id="tel"  numberOnly placeholder="숫자만입력"  maxlength="11">
                                    </td>
                                </tr>
                                <tr>
                                    <th>
                                        <span class="star">*</span>관리자 권한</th>
                                    <td>
                                        <select class="select1" style="width:250px;" name="auth" id="auth">
                                            <option value="">권한선택</option>
                                            <option value="SILVER">SILVER : 단순조회</option>
                                            <option value="GOLD">GOLD : 단순조회, 통계</option>
                                            <option value="SUPER">SUPER : 단순조회, 통계, 관리자등록</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>사용여부</th>
                                    <td>
                                        <input type="radio" id="r1" checked name="use_yn"  value="Y"/>
                                        <label for="r1">
                                            <span></span>사 용</label>
                                        <input type="radio" id="r2" name="use_yn" value="N"/>
                                        <label for="r2">
                                            <span></span>미사용</label>
                                    </td>
                                </tr>
                                <tr>
                                    <th>비 고</th>
                                    <td>
                                        <input type="text" class="input6" placeholder="" style="95%;"  name="memo" id="memo"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- 등록-->
                        <div class="btngroup textcenter">
                            <button type="button" class="btn1 bgwhite" onclick="location.href='menu0301.do'">취 소</button>
                            <button type="button" class="btn1 bgbluesky" onclick="db_action('INSERT')">등 록</button>
                        </div>
                        <!-- 등록-->
                        
                        
                        </form>
                    </div>
                    <!--contents end-->
                    <jsp:include  page="../include/footer.jsp" flush="true"/>
                </div>
                <!--ContentWrap end-->
            </section>
            <!-- section end -->
        </div>
    </body>
</html>
		