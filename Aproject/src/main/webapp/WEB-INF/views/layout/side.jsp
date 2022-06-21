<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
		<!-- Sidebar - Brand -->
	    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="home.do">
	        <div class="sidebar-brand-icon rotate-n-15">
	            <i class="fas fa-laugh-wink"></i>
	        </div>
	        <div class="sidebar-brand-text mx-3">Aproject</div>
	    </a>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider my-0">
	
		<c:if test="${memberVO.member_auth == 0 }">
			<!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#memberPage"
		            aria-expanded="true" aria-controls="collapsePages">
		            <i class="fas fa-fw fa-folder"></i>
		            <span>회원관리</span>
		        </a>
		        <div id="memberPage" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		            	<h6 class="collapse-header">MEMBER</h6>
		                <a class="collapse-item" href="memberSelectList.do">회원 목록</a>
		                <a class="collapse-item" href="memberAdminInputForm.do">회원 등록</a>
		                <a class="collapse-item" href="memberYnForm.do">가입 승인</a>
		                <div class="collapse-divider"></div>
		            </div>
		        </div>
		    </li>
		    <!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#sectionPage"
		            aria-expanded="true" aria-controls="collapsePages">
		            <i class="fas fa-fw fa-folder"></i>
		            <span>부서관리</span>
		        </a>
		        <div id="sectionPage" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		         	  	<h6 class="collapse-header">SECTION</h6>
		                <a class="collapse-item" href="sectionSelectList.do">부서목록</a>
		                <a class="collapse-item" href="sectionInsertForm.do">부서등록</a>
		            </div>
		        </div>
		    </li>
		</c:if>    
	    
	    <!-- Nav Item - Pages Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#emailPage"
	            aria-expanded="true" aria-controls="collapseTwo">
	            <i class="fa-solid fa-envelope" style="padding-left: 2px;"></i>
	            <span>메일관리</span>
	        </a>
	        <div id="emailPage" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <h6 class="collapse-header">EMAIL</h6>
	                <c:if test="${empty memberVO.member_mail_email}">
		                <a class="collapse-item" href="emailLogin.do">메일 계정 로그인</a>
	                </c:if>
	                <c:if test="${not empty memberVO.member_mail_email}">
	                	<a class="collapse-item" href="emailSend.do">메일 전송</a>
	                	<a class="collapse-item" href="emailRecieve.do">받은 메일함</a>
	                	<a class="collapse-item" href="emailSentMail.do">보낸 메일함</a>
		                <a class="collapse-item" href="emailLogout.do">메일 계정 로그아웃</a>
	                </c:if>
	            </div>
	        </div>
	    </li>
	
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#calendarPage"
	            aria-expanded="true" aria-controls="collapseUtilities">
	            <i class="fa-solid fa-calendar" style="padding-left: 2px;"></i>
	            <span>일정관리</span>
	        </a>
	        <div id="calendarPage" class="collapse" aria-labelledby="headingUtilities"
	            data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	            	<h6 class="collapse-header">CALENDAR</h6>	
	                <a class="collapse-item" href="calendar.do">일정</a>
	            </div>
	        </div>
	    </li>
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#boardPage"
	            aria-expanded="true" aria-controls="collapseUtilities">
	            <i class="fa-solid fa-comments" style="padding-left: 2px;"></i>
	            <span>커뮤니티</span>
	        </a>
	        <div id="boardPage" class="collapse" aria-labelledby="headingUtilities"
	            data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <h6 class="collapse-header">BOARD</h6>
	                <a class="collapse-item" href="boardList.do">게시판 목록</a>
	                <a class="collapse-item" href="boardInputForm.do">게시판 등록</a>
	            </div>
	        </div>
	    </li>
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#commutePage"
	            aria-expanded="true" aria-controls="collapseUtilities">
	            <i class="fa-solid fa-user-plus" style="padding-left: 2px;"></i>
	            <span>출퇴근</span>
	        </a>
	        <div id="commutePage" class="collapse" aria-labelledby="headingUtilities"
	            data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	            	<h6 class="collapse-header">COMMUTE</h6>
	            	 <c:if test="${ memberVO.member_auth == 0}">
	            	<a class="collapse-item" href="commuteEmpSelectList.do">사원 전체 출퇴근 관리</a>
	            	</c:if>
	            	
	            	<c:if test="${memberVO.member_auth == 1}">
	                <a class="collapse-item" href="commuteSelectList.do">출퇴근 관리</a>
	                </c:if>
	            </div>
	        </div>
	    </li>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider">
	
	</ul>
	<!-- End of Sidebar -->
</body>
</html>