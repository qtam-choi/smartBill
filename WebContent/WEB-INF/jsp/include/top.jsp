<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

		<header class="fclear">
              <h1>
                  <a href="/main.do"><img src="<c:url value='/images/logo.png'/>" style="width:120%;" alt="스마트 전자영수증 시스템관리자 로고"></a>
              </h1>
              <div class="header_menu">
                  <p>
                      <strong>로그인 일시  <fmt:formatDate value="${sessionScope.USER_INFO.login_date}" pattern="yyyy.MM.dd HH:mm:ss"/> </strong>
                      &nbsp;&nbsp;&nbsp;
                            30분 동안 동작이 없으면 자동 로그아웃 됩니다.
                  </p>
                  <button type="button" class="min-btn" onClick="goExtension()">30분 연장</button>
                  <button type="button" class="logout-btn" onClick="logOut();">로그아웃</button>
              </div>
          </header>

		
	