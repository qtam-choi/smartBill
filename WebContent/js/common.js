$(function(){
	// left sldemenu
  $.sidebarMenu($('.sidebar-menu'));
	
  // left menu toggle	
	$(".menu_click").on("click", function(){
		if ( $(this).hasClass("folded") === false ) { 
			$(".cate_wrap").animate({left:"-220"}, 500, "easeInOutQuint");
			$(".ContentWrap").animate({marginLeft:0}, 500, "easeInOutQuint");
			$(this). find('img').attr("src","images/icon_menu.png");
			$(this).addClass("folded");
		} else { 
			$(".cate_wrap").animate({left:"0"}, 500, "easeInOutQuint");
			$(".ContentWrap").animate({marginLeft:220}, 500, "easeInOutQuint");
			$(this). find('img').attr("src","images/icon_menu2.png");
			$(this).removeClass("folded");
		}
	});

	// Main tabmenu
		$(".tab_content").hide();
		$(".tab_content:first").show();

		$("ul.tabs li").click(function () {
			$("ul.tabs li").removeClass("active").css("", "");
			$(this).addClass("active").css("", "");
			$(".tab_content").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});
	
	// datepicker
	$( "#datepicker1, #datepicker2" ).datepicker({
		dateFormat: 'yy-mm-dd',
		prevText: '이전 달',
		nextText: '다음 달',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일','월','화','수','목','금','토'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['일','월','화','수','목','금','토'],
		showMonthAfterYear: true,
		changeMonth: true,
		changeYear: true,
		yearSuffix: '년'
	});


	// custom scrollbar
	$(".ContentWrap, .ManageWrap >  div:first-child ").niceScroll({cursorcolor:"rgba(216,226,233,1)", cursorwidth:6, cursorborder: "1px solid rgba(255,255,255,0)"});
		
});