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
		$('#form1').attr('action', 'menu0301Detail.do');
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
                
                <div
                    class="ContentWrap">
                    <!--title nav start-->
                    <h2>사용자 관리</h2>
                    <div class="nav">
                        <img src="<c:url value='/images/icon_home.png'/>" alt="home"><span><img src="<c:url value='/images/icon_nav.png'/>" alt="step">
                            사용자 관리</span>
                        <img src="<c:url value='/images/icon_nav.png'/>" alt="step"><span>
                            <strong>사용자 목록</strong>
                        </span>
                    </div>
                    
                    <form name="form1" id="form1"  method="POST" >
                    	<INPUT type="hidden" id="curPage" name="curPage" value="${requestScope.paging.curPage}"/>
						<INPUT type="hidden" id="no" name="no" value=""/>
                    
                    <!--title nav end-->
                    <table class="BasicTbl2 Tbl_top" style="margin-bottom:10px;">
                        <colgroup>
                            <col width="13%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                        	<tr>
                        		<th>상태</th>
                                <td>
                                    <select class="select1" style="width:160px;" name="use_yn">
                                        <option value="">전 체</option>
                                        <option <c:if test="${param.use_yn == 'Y'}"> selected="selected" </c:if> value="Y">사용</option>
                                        <option <c:if test="${param.use_yn == 'N'}"> selected="selected" </c:if> value="N">미사용</option>
                                    </select>
                             	</td>
                        	</tr>
                        	<tr>
	                            <th>사용자 검색</th>
	                            <td>
	                                <select class="select1" style="width:160px;" name="searchType">
	                                    <option value="user_id" <c:if test="${param.searchType == 'user_id'}"> selected="selected" </c:if>>아이디</option>
	                                    <option value="user_nm" <c:if test="${param.searchType == 'user_nm'}"> selected="selected" </c:if>>이름</option>
	                                </select>
	                                <input type="text" class="input5" style="width:300px;"  name="searchValue" value="${param.searchValue}" onkeydown="javascript:if(event.keyCode==13){goSearch();}">
	                                <button type="button" class="btn1 bgblue" onclick="goSearch();">검 색</button>
	                            </td>
	                         </tr>   
                        </tbody>
            	</table>
            <!--contents start-->
            
            <div class="contents">
                <div style=" display:table; table-layout:auto; width:95%; margin:0 auto">
                    <div style="display:table-cell; width:50%; text-align:left; padding:4px 0px; font-size:12px; ">총 검색 대상 <b style="color:#03F">${requestScope.paging.totalRecord}</b>개</div>
                    <div style="display:table-cell; width:50%; text-align:right; padding:4px 0px">
                        <select class="select1" style="width:80px;" name="rowCnt">
                            <option <c:if test="${param.rowCnt == '10'}"> selected="selected" </c:if> value="10">10</option>
                            <option <c:if test="${param.rowCnt == '20'}"> selected="selected" </c:if> value="20">20</option>
                            <option <c:if test="${param.rowCnt == '30'}"> selected="selected" </c:if> value="30">30</option>
                            <option <c:if test="${param.rowCnt == '40'}"> selected="selected" </c:if> value="40">40</option>
                            <option <c:if test="${param.rowCnt == '50'}"> selected="selected" </c:if> value="50">50</option>
                        </select>
                    </div>
                </div>
                <table class="BasicTbl4 Tblink">
                    <col width="7%"/>
                    <col width="18%"/>
                    <col width="10%"/>
                    <col width="15%"/>
                    <col width="20%"/>
                    <col width="20%"/>
                    <col width="10%"/>
                    
                    <tr>
                        <th>No</th>
                        <th>아이디</th>
                        <th>이름</th>
                        <th>권한</th>
                        <th>최종 로그인</th>
                        <th>등록일시</th>
                        <th>상태</th>
                    </tr>
                     <!-- 리스트 -->
 					<c:forEach items="${requestScope.dataList}" var="list" varStatus="status">
                    
                     <tr onclick="goDetail('${list.no}');" >
                        <td>${requestScope.paging.listNo - status.index}</td>
                        <td>${list.user_id }</td>
                        <td>${list.user_nm }</td>
                        <td>${list.auth }</td>
                        <td><fmt:formatDate value="${list.last_login_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td><fmt:formatDate value="${list.apply_date}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                        <td>${list.status }</td>
                    </tr>
                    
                    
                    
                    </c:forEach>
                    
                    		   
                   <c:if test="${fn:length(requestScope.dataList) == 0}">
						<tr><td colspan="7" style="padding:10px;">검색된 내용이 없습니다.</td></tr>
					</c:if> 		   
                    		   
                    		   
                </table>
                <!-- 등록-->
                <div class="btngroup textright">
                    <button type="button" class="btn1 bgbluesky" onclick="location.href='menu0301Reg.do'">등 록</button>
                </div>
                <!-- 등록-->
                
                
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
		