<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

				<div class="paging">
                  <a onclick="javascript:goPage('1'); return false;" style="cursor:pointer;"><img src="<c:url value='/images/paging_first.gif'/>" alt="맨처음으로"></a>
                  <a onclick="javascript:goPage(${param.prevLink}); return false;" style="cursor:pointer;">
                  	<img src="<c:url value='/images/paging_prev.gif'/>" alt="이전페이지">
                  </a>
                  
                  <c:forEach begin="${param.firstPage}" end="${param.lastPage}" var="pageNum" >
					<c:choose>
						<c:when test="${param.curPage == pageNum}">
							<a  class="active">${pageNum}</a>
						</c:when>
						<c:otherwise>
							<a onclick="javascript:goPage(${pageNum}); return false;" style="cursor:pointer;">${pageNum }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>	
                  
                  <a onclick="javascript:goPage(${param.nextLink}); return false;" style="cursor:pointer;"><img src="<c:url value='/images/paging_next.gif'/>" alt="다음페이지"></a>
                  <a onclick="javascript:goPage(${param.totalPage}); return false;" style="cursor:pointer;"><img src="<c:url value='/images/paging_last.gif'/>" alt="마지막으로"></a>
              </div>
  

						
