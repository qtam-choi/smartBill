<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<jsp:include  page="../include/header.jsp" flush="true"/>
<script type="text/javascript">	
	 
	function goDetail(no){
		var sendObj = document.getElementById("form1");
		
		$('#no').val(no);
		$('#form1').attr('action', 'menu0101Detail.do');
		sendObj.submit();
		
	} 
	
	
	function db_action(act)
    {	
		
		if($("input[name=sel_chk]:checked").length == 0){
			alert('선택한 것이 없습니다.');
			return;
		}
	
		
		if(act == '삭제'){
			if(!confirm('삭제할까요?')){
				return;
			}			
		}
		
		var sel_check = [];

        $("input[name=sel_chk]:checked").each(function(i) {
        	sel_check.push($(this).val());
        });

		
    	var dataArr = getFormData($("#form1")); 
    	dataArr.action = act;
    	dataArr.sel_check = sel_check;
    	 
    	$.ajax({
    	    type : "POST" 
    	    , async : true
    	    , url : "menu0101Action.do"
    	    , dataType : "json"
    	    , data : dataArr
    	    , traditional: true
    	    , beforeSend: function() {
    	    	$.blockUI({ message: '<h1><br/><img src="<c:url value='/images/busy.gif'/>" width="20"/>&nbsp;&nbsp;DB 작업 중입니다. 창을 닫지 마세요.<br/><br/>' }); 
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
    	    		alert('처리 되었습니다.');
    	    		$('#form1').submit();
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
                
                <div
                    class="ContentWrap">
                    <!--title nav start-->
                    <h2>가입자 통계</h2>
                    <div class="nav">
                        <img src="<c:url value='/images/icon_home.png'/>" alt="home"><span><img src="<c:url value='/images/icon_nav.png'/>" alt="step">
                            가입자 통계</span>
                    </div>
                    <!--title nav end-->
                     <form name="form1" id="form1"  method="POST" >
                    <table class="BasicTbl2 Tbl_top" style="margin-bottom:10px;">
                        <colgroup>
                            <col width="13%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>일자 조회</th>
                                <td>
                                     <input type="text" class="input5" id="datepicker1" autocomplete="off"  name="startDate"  readOnly value="${requestScope.startDate }">
                                    ~
                                    <input type="text" class="input5" id="datepicker2" autocomplete="off"  name="endDate"  readOnly value="${requestScope.endDate }">
                                </td>
                            </tr>
                            <tr>
                                <th>밴 사</th>
                                <td>
                                    <select class="select1" style="width:160px;"  name="app_van">
                                        <option value="">전체</option>
                                        <option value="SMARTRO" <c:if test="${param.app_van == 'SMARTRO'}"> selected="selected" </c:if>>스마트로</option>
                                        <option value="NICE" <c:if test="${param.app_van == 'NICE'}"> selected="selected" </c:if>>나이스</option>
                                        <option value="ETC" <c:if test="${param.app_van == 'ETC'}"> selected="selected" </c:if>>기타</option>
                                    </select>
                                    <button type="button" class="btn1 bgblue" onclick="goSearch()">검 색</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!--contents start-->
                    <div class="contents">
                        <table class="BasicTbl4 mt30">
                            <col width="35%"/>
                            <col width="35%"/>
                            <col width="15%"/>
                            <col width=""/>
                            <tr>
                            
                                <th>밴사</th>
                                <th>가맹점</th>
                                <th>카드등록 수</th>
                                <th>영수증 수</th>
                            </tr>
                            
                              <!-- 리스트 -->
		 					<c:forEach items="${requestScope.dataList}" var="list" varStatus="status">
		 					
                            <tr>
                                <td >${list.app_van }</td>
                                <td ><c:forEach var="i" begin="1" end="${fn:length(list.pos_store_nm)+6}">*</c:forEach></td>
                                <td>${list.cnt }</td>
                                <td>${list.receipt_cnt }</td>
                            </tr>
                            
                            </c:forEach>
                            
                            <c:if test="${fn:length(requestScope.dataList) == 0}">
								<tr><td colspan="3" style="padding:10px;">검색된 내용이 없습니다.</td></tr>
							</c:if> 
                            
                            
                        </table>
                    </div>
                    
                    </form>
                    
                    
                    <jsp:include  page="../include/footer.jsp" flush="true"/>
                </div>
                <!--ContentWrap end-->
            </section>
            <!-- section end -->
        </div>
    </body>
</html>
		