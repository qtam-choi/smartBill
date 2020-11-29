<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<jsp:include  page="../include/header.jsp" flush="true"/>
<script type="text/javascript">	
	
function goDetail2(){
	var sendObj = document.getElementById("form1");
	
	$('#form1').attr('action', 'menu0101Detail2.do');
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
                            <strong>영수증 사서함 수신/열람</strong>
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
                            <td>${fn:substring(list.name,0,1)}<c:if test="${fn:length(list.name)!=0}}">*</c:if>${fn:substring(list.name,2,3)}</td>
                            <td>${fn:substring(list.cust_hp,0,3)}<c:if test="${fn:length(list.cust_hp)!=0}}">****</c:if>${fn:substring(list.cust_hp,7,11)}</td>
                            
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
                    <div class="contents">
                        <ul class="tabs">
                            <li class="active"  style="width:200px;">영수증 사서함 수신/열람</li>
                            <li onclick="goDetail2();" style="width:200px;">사용 변경 이력</li>
                        </ul>
                        
                        <form name="form1" id="form1"  method="POST" >
                    	<INPUT type="hidden" id="curPage" name="curPage" value="${requestScope.paging.curPage}"/>
						<INPUT type="hidden" id="identify_key" name="identify_key" value="${requestScope.dataView.identify_key}"/>
                        
                        
                        <table class="BasicTbl2 mt20">
                            <colgroup>
                                <col width="13%">
                                <col width="32%">
                                <col width="13%">
                                <col width="*">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th>기간조회</th>
                                    <td>
                                         <input type="text" class="input5" id="datepicker1" autocomplete="off"  name="startDate"  readOnly value="${requestScope.startDate }">
	                                    ~
	                                    <input type="text" class="input5" id="datepicker2" autocomplete="off"  name="endDate"  readOnly value="${requestScope.endDate }">
                               </td>
                                    <th>상태</th>
                                    <td>
                                        <select class="select1" style="width:160px;"  name="yn_cancel_type">
                                            <option value="">전 체</option>
                                            <option value="N" <c:if test="${param.yn_cancel_type == 'N'}"> selected="selected" </c:if>>승인</option>
                                            <option value="B" <c:if test="${param.yn_cancel_type == 'B'}"> selected="selected" </c:if>>취소</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>발행 VAN사</th>
                                    <td>
                                        <select class="select1" style="width:160px;"  name="app_van">
                                            <option value="">전 체</option>
                                            <option value="SMARTRO" <c:if test="${param.app_van == 'SMARTRO'}"> selected="selected" </c:if>>스마트로</option>
                                            <option value="NICE" <c:if test="${param.app_van == 'NICE'}"> selected="selected" </c:if>>나이스</option>
                                            <option  value="ETC" <c:if test="${param.app_van == 'ETC'}"> selected="selected" </c:if>>기타</option>
                                        </select>
                                    </td>
                                    <th>발행가맹점</th>
                                    <td>
                                    <input type="hidden"  name="searchType" value="pos_store_nm">
                                    <input type="text" class="input5" style="width:160px;" name="searchValue"  value="${param.searchValue}">
                                        
                                        <button type="button" class="btn1 bgblue" onclick="goSearch();">검 색</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="BasicTbl4 mt20">
                            <col width="7%"/>
                            <col width="10%"/>
                            <col width="9%"/>
                            <col width="10%"/>
                            <col width="11%"/>
                            <col width="15%"/>
                            <col width="8%"/>
                            <col width="10%"/>
                            <col width="10%"/>
                            <col width=""/>
                            <tr>
                                <th>NO</th>
                                <th>발행일</th>
                                <th>사용 App</th>
                                <th>발행    밴사</th>
                                <th>발행가맹점</th>
                                <th>카드번호</th>
                                <th>사용금액</th>
                                <th>영수증 상태</th>
                                <th>수신</th>
                                <th>열람</th>
                            </tr>
                            
                            
                            <c:forEach items="${requestScope.dataList}" var="list" varStatus="status">
                            <tr>
                                <td>${requestScope.paging.listNo - status.index}</td>
                                <td><fmt:formatDate value="${list.reg_at}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                                <td>${list.app_type }</td>
                                <td>${list.app_van }</td>
                                <td>${list.pos_store_nm }</td>
                                <td>${list.inv_card_no }</td>
                                <td><fmt:formatNumber type="currency" value="${list.sub_total}" pattern="###,###" /></td>
                                <td>${list.status }</td>
                                <td><fmt:formatDate value="${list.recv_at}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                                <td><fmt:formatDate value="${list.view_at}" pattern="yyyy.MM.dd HH:mm:ss"/></td>
                            </tr>
                             </c:forEach>
                    
                    		   
		                   <c:if test="${fn:length(requestScope.dataList) == 0}">
								<tr><td colspan="10" style="padding:10px;">검색된 내용이 없습니다.</td></tr>
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
		