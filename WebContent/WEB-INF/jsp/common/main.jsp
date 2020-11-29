<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<jsp:include  page="../include/header.jsp" flush="true"/>
<script type="text/javascript">	
	
	$(document).ready(function () {
		
		db_action('MAIN');
        
    });
	
	
	
	function db_action(act)
    {	
		
		
		
    	var dataArr = getFormData($("#form1")); 
    	dataArr.action = act;
    	
    	$.ajax({
    	    type : "POST" 
    	    , async : true
    	    , url : "<c:url value='/common/commonAction.do' />"
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
    	    		
    	    		$(".ContentWrap").css("overflow", "scroll");
    	    		
    	    		
    	    		var ticks = data.channelArr
    	            plot2b = $.jqplot('chart2', [data.totCntArr, data.todayCntArr] 
    	            	, {
    	                animate: true,
    	                animateReplot: true,
    	                seriesDefaults: {
    	                    renderer: $.jqplot.BarRenderer,
    	                    shadow: 0,
    	                    pointLabels: {
    	                        show: true,
    	                        location: 'e',
    	                        edgeTolerance: -15
    	                    },
    	                    shadowAngle: 135,
    	                    rendererOptions: {
    	                        barDirection: 'horizontal'
    	                    }
    	                },
    	                axes: {
    	                    yaxis: {
    	                        renderer: $.jqplot.CategoryAxisRenderer,
    	                        ticks: ticks
    	                    }
    	                }
    	            });
    	    		
    	    		var tot_cnt =0, today_cnt =0;
    	    		
    	    		$.each(data.venInfoList, function(i, e) {
		    			$("._ven_list").append("<tr><td class='Tblsub'>"+e.app_van_desc+"</td><td>"+comma(e.tot_cnt)+"</td><td>"+comma(e.today_cnt) +"</td></tr>");
		    			
		    			tot_cnt += e.tot_cnt;
		    			today_cnt += e.today_cnt;
		    			
					});	
    	    		
    	    		$("._ven_list").append("<tr><td class='Tblsub'>전체</td><td>"+comma(tot_cnt)+"</td><td>"+comma(today_cnt) +"</td></tr>");
    	    		
    	    		/////////////////////////////////////////////////////
  	    	
 	    	            plot2 = $.jqplot('chart3', [
								data.passArr, data.naverArr, data.kakaoArr,  data.etcArr
 	    	            ], {
 	    	                animate: true,
 	    	                // Will animate plot on calls to plot1.replot({resetAxes:true})
 	    	                animateReplot: true,
 	    	                seriesColors: ['#c5b47f' , '#579575', '#eaa228', '#bbbbbb' ],
 	    	                seriesDefaults: {
 	    	                    renderer: $.jqplot.BarRenderer,
 	    	                    shadow: 0,
 	    	                    pointLabels: {
 	    	                        show: true
 	    	                    }
 	    	                },
 	    	                axes: {
 	    	                    xaxis: {
 	    	                        renderer: $.jqplot.CategoryAxisRenderer,
 	    	                        ticks: data.regDateArr
 	    	                    }
 	    	                }
 	    	            });
    	    		
    	    		
 	    	           $.each(data.receptTotList, function(i, e) {
 			    			$("._recept_list").append("<tr><td>"+e.reg_at+"</td><td>"+comma(e.tot_cnt)+"</td><td>"+comma(e.smartro_pass_cnt)+"</td><td>"+comma(e.smartro_naver_cnt)+"</td><td>"+comma(e.smartro_kakao_cnt)+"</td><td>"+comma(e.smartro_null_cnt)+"</td><td>"+comma(e.nice_pass_cnt)+"</td><td>"+comma(e.nice_naver_cnt)+"</td><td>"+comma(e.nice_kakao_cnt)+"</td><td>"+comma(e.nice_null_cnt)+"</td><td>"+comma(e.van_pass_cnt)+"</td><td>"+comma(e.van_naver_cnt)+"</td><td>"+comma(e.van_kakao_cnt)+"</td><td>"+comma(e.van_null_cnt)+"</td></tr>");
 						});	
 	    	           
 	    	           
 	    	          $(".ContentWrap").css("overflow", "hidden");
 	    	           
 	    	 	
				/////////////////////////////////////////////////////
    	    		
    	    		
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
                    <h2>대시보드</h2>
                    <div class="nav">
                        <img src="<c:url value='/images/icon_home.png'/>" alt="home"><span><img src="<c:url value='/images/icon_nav.png'/>" alt="step">
                            대시보드</span>
                    </div>
                    <!--title nav end-->
                    <!--contents start-->
                    <div class="contents" style="padding-bottom:10px">
                        <h3 class="mt20">VAN사별 가입자
                        </h3>
                        <ul class="dashboard-topbox">
                            <li>
                                <!-- chart-->
                                <div id="chart2"></div>
                                <!-- chart-->
                                <div class="dashtxt">
                                    <span style=" background:#eaa228">
                                        &nbsp; &nbsp;</span>&nbsp;신규가입자 &nbsp; &nbsp;
                                    <span style=" background:#4bb2c5">
                                        &nbsp; &nbsp;</span>&nbsp;전체가입자 &nbsp; &nbsp;
                                </div>
                            </li>
                            <li>
                                <!-- van grid -->
                                <table class="BasicTbl4 _ven_list"  >
                                    <tr>
                                        <th>매체
                                        </th>
                                        <th>전체가입자
                                        </th>
                                        <th>신규    가입자
                                        </th>
                                    </tr>
                                    
                                </table>
                                <!-- van grid -->
                            </li>
                        </ul>
                        
                    </div>
                    <!--contents end-->
                    <!--contents start-->
                    <div class="contents mt10">
                        <h3 class="mt20">전자영수증 발급 통계</h3>
                        <!-- chart-->
                        <div id="chart3"></div>
                        <!-- chart-->
                        <div class="chart3txt">
                            <span style=" background:#c5b47f">
                                &nbsp; &nbsp;</span>&nbsp;PASS &nbsp; &nbsp;
                            <span style=" background:#579575">
                                &nbsp; &nbsp;</span>&nbsp;네이버 &nbsp; &nbsp;
                            <span style=" background:#eaa228">
                                &nbsp; &nbsp;</span>&nbsp;카카오&nbsp; &nbsp;
                            <span style=" background:#bbbbbb">
                                &nbsp; &nbsp;</span>&nbsp;미사용&nbsp; &nbsp;
                                			&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
                             <c:set var="now" value="<%=new java.util.Date()%>" />  			
                                			* <fmt:formatDate value="${now}" pattern="yyyy-MM-dd hh:mm" /> 기준
                        </div>
                        <table class="BasicTbl4 mt20">
                            <colgroup>
                                <col width="14%">
                                <col width="14%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                                <col width="6%">
                            </colgroup>
                            <tbody  class="_recept_list">
                                <tr>
                                    <th rowspan="2">발급일자
                                    </th>
                                    <th rowspan="2">누적 발송 통계
                                    </th>
                                    <th class="Tblth" colspan="4">스마트로</th>
                                    <th class="Tblth" colspan="4">나이스</th>
                                    <th class="Tblth" colspan="4">기타</th>
                                </tr>
                                <tr>
                                    <td class="Tblsub">PASS
                                    </td>
                                    <td class="Tblsub">네이버
                                    </td>
                                    <td class="Tblsub">카카오
                                    </td>
                                    <td class="Tblsub">미사용
                                    </td>
                                    <td class="Tblsub">PASS
                                    </td>
                                    <td class="Tblsub">네이버
                                    </td>
                                    <td class="Tblsub">카카오
                                    </td>
                                    <td class="Tblsub">미사용
                                    </td>
                                    <td class="Tblsub">PASS
                                    </td>
                                    <td class="Tblsub">네이버
                                    </td>
                                    <td class="Tblsub">카카오
                                    </td>
                                    <td class="Tblsub">미사용
                                    </td>
                                </tr>
                               
                            </tbody>
                        </table>
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
		