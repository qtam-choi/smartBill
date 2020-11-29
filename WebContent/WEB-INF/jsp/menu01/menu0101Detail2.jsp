<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<jsp:include  page="../include/header.jsp" flush="true"/>
<script type="text/javascript">	
	 

function goDetail(){
	var sendObj = document.getElementById("form1");
	
	$('#form1').attr('action', 'menu0101Detail.do');
	sendObj.submit();
	
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
                <!--ContentWrap start-->
                <!--ContentWrap start-->
                <div
                    class="ContentWrap">
                    <!--title nav start-->
                    <h2>전자영수증 사서함관리</h2>
                    <div class="nav">
                        <img src="<c:url value='/images/icon_home.png'/>" alt="home"><span><img src="<c:url value='/images/icon_nav.png'/>" alt="step">
                            가입자 관리</span>
                        <img src="<c:url value='/images/icon_nav.png'/>" alt="step"><span>
                            <strong>전자영수증 회원관리</strong>
                        </span>
                        <img src="<c:url value='/images/icon_nav.png'/>" alt="step"><span>
                            <strong>사용 변경 이력</strong>
                        </span>
                    </div>
                    <!--title nav end-->
                    <!--contents start-->
                    <h3 class="tb">가입자 정보</h3>
                    <table class="BasicTbl2 Tbl_top" style="margin-bottom:10px;">
                        <col width="17%"/>
                        <col width="33%"/>
                        <col width="17%"/>
                        <col width="33%"/>
                        <tr>
                            <th>이름</th>
                            <td>${requestScope.dataView.name}</td>
                            <th>연락처</th>
                            <td>${requestScope.dataView.cust_hp}</td>
                        </tr>
                        <tr>
                            <th>가입 가맹점</th>
                            <td>${requestScope.dataView.pos_store_nm}</td>
                            <th>가입 밴사</th>
                            <td>${requestScope.dataView.app_van}</td>
                        </tr>
                        <tr>
                            <th>가입일</th>
                            <td><fmt:formatDate value="${requestScope.dataView.reg_at}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                            <th>사용 App</th>
                            <td>${requestScope.dataView.app_type}</td>
                        </tr>
                        <tr>
                            <th>상태</th>
                            <td colspan="3">정상</td>
                        </tr>
                    </table>
                    <div
                        class="contents">
                        <!-- TAB -->
                        <ul class="tabs">
                            <li onclick="goDetail();" style="width:200px;">영수증 사서함 수신/열람</li>
                            <li class="active"  style="width:200px;">사용 변경 이력</li>
                        </ul>
                        <!-- TAB -->
                         <form name="form1" id="form1"  method="POST" >
                    	<INPUT type="hidden" id="curPage" name="curPage" value="${requestScope.paging.curPage}"/>
						<INPUT type="hidden" id="identify_key" name="identify_key" value="${requestScope.dataView.identify_key}"/>
                        
                        
                        
                        <table class="BasicTbl4 mt30">
                            <col width="185"/>
                            <col width="311" span="2"/>
                            <tr>
                                <th>NO</th>
                                <th>사용 App</th>
                                <th>변경일</th>
                            </tr>
                            
                            
	                        <c:forEach items="${requestScope.dataList}" var="list" varStatus="status">
		                        <tr>
	                                <td>${requestScope.paging.listNo - status.index}</td>
	                                <td>${list.app_type }</td>
	                                <td><fmt:formatDate value="${list.reg_at}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
	                              
	                            </tr>
	                        
	                        
	                        </c:forEach>
	                    
                    		   
		                   <c:if test="${fn:length(requestScope.dataList) == 0}">
								<tr><td colspan="8" style="padding:10px;">검색된 내용이 없습니다.</td></tr>
							</c:if> 	
                           
                        </table>
                        
                        
                         <!-- s:paging -->
						<c:if test="${fn:length(requestScope.dataList) != 0}">
						
							<jsp:include  page="../include/paging.jsp" flush="true">
							    <jsp:param name="curPage" value="${requestScope.paging.curPage}" />
							    <jsp:param name="prevLink" value="${requestScope.paging.prevLink}" />
							    <jsp:param name="nextLink" value="${requestScope.paging.nextLink}" />
							    <jsp:param name="totalPage" value="${requestScope.paging.totalPage}" />
							    <jsp:param name="firstPage" value="${requestScope.paging.firstPage}" />
							    <jsp:param name="lastPage" value="${requestScope.paging.lastPage}" />
							</jsp:include>
						
						</c:if> 
						<!-- e: 버튼 --> 
                        
                        
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
		
		