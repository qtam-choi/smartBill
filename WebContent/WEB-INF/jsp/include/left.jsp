<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="urlString"  value="${pageContext.request.requestURL}" />


<!-- cate_wrap start -->
  <div class="cate_wrap">
      <div class="menu_click"><img src="<c:url value='/images/icon_menu2.png'/>" alt="menu open&close"></div>
      <!-- left menu start -->
      <div class="left_menu">
          <ul class="sidebar-menu">
              <li class="treeview <c:if test="${fn:contains(urlString, 'main')}"> active </c:if>">
                  <a href="<c:url value='/main.do'/>">
                      <span>대시보드</span>
                  </a>
              </li>
              
              <li class="treeview <c:if test="${fn:contains(urlString, '/menu01/')}"> active </c:if>">
                  <a href="">
                      <span>가입자관리</span>
                  </a>
                  <ul class="treeview-menu">
                      <li <c:if test="${fn:contains(urlString, 'menu0101')}">class="active" </c:if>>
                          <a href="<c:url value='/menu01/menu0101.do'/>">전자영수증 사서함관리</a>
                      </li>
                      <li <c:if test="${fn:contains(urlString, 'menu0102')}">class="active" </c:if>>
                          <a href="<c:url value='/menu01/menu0102.do'/>">사서함 동의관리</a>
                      </li>
                  </ul>
              </li>
              
              
              
              <c:if test="${sessionScope.USER_INFO.auth == 'GOLD' || sessionScope.USER_INFO.auth == 'SUPER'}">
              
              <li class="treeview  <c:if test="${fn:contains(urlString, '/menu02/')}"> active </c:if>">
                  <a href="<c:url value='/menu02/menu0201.do'/>">
                      <span>가입자 통계</span>
                  </a>
              </li>
              
              </c:if>
              
              
              <c:if test="${sessionScope.USER_INFO.auth == 'SUPER'}">
              
              <li class="treeview  <c:if test="${fn:contains(urlString, '/menu03/')}"> active </c:if>">
                  <a href="<c:url value='/menu03/menu0301.do'/>">
                      <span>시스템관리</span>
                  </a>
                  <ul class="treeview-menu">
                      <li <c:if test="${fn:contains(urlString, 'menu0301')}">class="active" </c:if>>
                          <a href="<c:url value='/menu03/menu0301.do'/>">사용자 관리</a>
                      </li>
                  </ul>
              </li>
              
              </c:if>
              
          </ul>
      </div>
      <!-- left menu  end-->
  </div>
  <!-- cate_wrap end -->