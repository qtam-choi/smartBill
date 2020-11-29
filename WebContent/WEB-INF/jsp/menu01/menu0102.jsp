<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<jsp:include  page="../include/header.jsp" flush="true"/>
<script type="text/javascript">	
	
</script>

</head>
<body>
        <div id="Wrap">

			<jsp:include  page="../include/top.jsp" flush="true"/>
            
            <!-- section start -->
            <section class="fclear">

                <jsp:include  page="../include/left.jsp" flush="true"/>
                
                
                
                 <!--ContentWrap start-->
                <div class="ContentWrap">
                    <!--title nav start-->
                    <h2>사서함 동의관리</h2>
                    <div class="nav">
                        <img src="<c:url value='/images/icon_home.png'/>" alt="home"><span><img src="<c:url value='/images/icon_nav.png'/>" alt="step">
                            가입자 관리</span>
                        <img src="<c:url value='/images/icon_nav.png'/>" alt="step"><span>
                            <strong>사서함 동의관리</strong>
                        </span>
                    </div>
                    <!--title nav end-->
                     <form name="form1" id="form1"  method="POST" >
                    	<INPUT type="hidden" id="curPage" name="curPage" value="${requestScope.paging.curPage}"/>
						<INPUT type="hidden" id="no" name="no" value=""/>
                    
                    
                    <table class="BasicTbl2 Tbl_top" style="margin-bottom:10px;">
                        <colgroup>
                            <col width="13%">
                            <col width="32%">
                            <col width="13%">
                            <col width="*">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>일자조회</th>
                                <td>
                                      <input type="text" class="input5" id="datepicker1" autocomplete="off"  name="startDate"  readOnly value="${requestScope.startDate }">
                                    ~
                                    <input type="text" class="input5" id="datepicker2" autocomplete="off"  name="endDate"  readOnly value="${requestScope.endDate }">
                                </td>
                                <th>상태</th>
                                <td>
                                    <select class="select1" style="width:160px;" name="status">
                                        <option value="">전 체</option>
                                        <option value="정상" <c:if test="${param.status == '정상'}"> selected="selected" </c:if>>정상</option>
                                        <option value="미사용" <c:if test="${param.status == '미사용'}"> selected="selected" </c:if>>미사용</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>사용 App</th>
                                <td colspan="3">
                                    <select class="select1" style="width:160px;" name="app_type">
                                        <option value="">전 체</option>
                                        <option value="PASS"  <c:if test="${param.app_type == 'PASS'}"> selected="selected" </c:if>>PASS</option>
                                        <option value="네이버" <c:if test="${param.app_type == '네이버'}"> selected="selected" </c:if>>네이버</option>
                                        <option value="카카오" <c:if test="${param.app_type == '카카오'}"> selected="selected" </c:if>>카카오</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>검색</th>
                                <td colspan="3">
                                    <select class="select1" style="width:160px;" name="searchType">
                                        <option value="name" <c:if test="${param.searchType == 'name'}"> selected="selected" </c:if>>사용자명</option>
                                        <option value="b.cust_hp" <c:if test="${param.searchType == 'b.cust_hp'}"> selected="selected" </c:if>>연락처</option>
                                    </select>
                                    <input type="text" class="input5" style="width:300px;" name="searchValue" value="${param.searchValue}" onkeydown="javascript:if(event.keyCode==13){goSearch();}">
                                    <button type="button" class="btn1 bgblue" onclick="goSearch()">검 색</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <!--contents start-->
                    <div class="contents">
                        <div class="mt20" style=" display:table; table-layout:auto; width:95%; margin:0 auto">
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
                        <table class="BasicTbl4">
                            <col width="7%"/>
                            <col width="15%"/>
                            <col width="15%"/>
                            <col width="26%"/>
                            <col width="16%"/>
                            <col width="10%"/>
                            <col width="10%"/>
                            <tr>
                                <th>No
                                </th>
                                <th>이름
                                </th>
                                <th>연락처
                                </th>
                                <th>가입채널
                                </th>
                                <th>사서함 동의일
                                </th>
                                <th>사용APP
                                </th>
                                <th>상태
                                </th>
                            </tr>
                           
                             <!-- 리스트 -->
		 					<c:forEach items="${requestScope.dataList}" var="list" varStatus="status">
		                    
		                     <tr >
                                <td>${requestScope.paging.listNo - status.index}</td>
                                <td>${fn:substring(list.name,0,1)}<c:if test="${fn:length(list.name)!=0}}">*</c:if>${fn:substring(list.name,2,3)}</td>
                                <td>${fn:substring(list.cust_hp,0,3)}<c:if test="${fn:length(list.cust_hp)!=0}}">****</c:if>${fn:substring(list.cust_hp,7,11)}</td>
                                <td>${list.reg_channel }<c:if test="${list.pos_store_nm ne null}">_${list.pos_store_nm }</c:if></td>
                                 <td><fmt:formatDate value="${list.agree_at}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                                <td>${list.app_type }</td>
                                 <td>${list.status }</td>
                            </tr>
                            </c:forEach>
                            
                             <c:if test="${fn:length(requestScope.dataList) == 0}">
								<tr><td colspan="7" style="padding:10px;">검색된 내용이 없습니다.</td></tr>
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
                    </div>
                    
                    </form>
                    <!--contents end-->
                    <jsp:include  page="../include/footer.jsp" flush="true"/>
                </div>
                <!--ContentWrap end-->
            </section>
            <!-- section end -->
        </div>
    </body>
</html>
		