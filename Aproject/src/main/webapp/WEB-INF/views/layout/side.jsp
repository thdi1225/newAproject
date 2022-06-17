<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
		<!-- Nav Item - Pages Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#memberPage"
	            aria-expanded="true" aria-controls="collapsePages">
	            <i class="fas fa-fw fa-folder"></i>
	            <span>회원관리</span>
	        </a>
	        <div id="memberPage" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <a class="collapse-item" href="memberSelectList.do">회원 목록</a>
	                <a class="collapse-item" href="memberAdminInputForm.do">회원 등록</a>
	                <a class="collapse-item" href="memberYnForm.do">가입 승인</a>
	                <div class="collapse-divider"></div>
	            </div>
	        </div>
	    </li>
	    <!-- Nav Item - Pages Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
	            aria-expanded="true" aria-controls="collapsePages">
	            <i class="fas fa-fw fa-folder"></i>
	            <span>부서관리</span>
	        </a>
	        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <a class="collapse-item" href="sectionSelectList.do">부서목록</a>
	                <a class="collapse-item" href="sectionInsertForm.do">부서등록</a>
	            </div>
	        </div>
	    </li>
	    
	    <!-- Nav Item - Pages Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
	            aria-expanded="true" aria-controls="collapseTwo">
	            <i class="fas fa-fw fa-cog"></i>
	            <span>메일관리</span>
	        </a>
	        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <h6 class="collapse-header">EMAIL</h6>
	                <a class="collapse-item" href="emailSend.do">메일 전송</a>
	                <a class="collapse-item" href="emailRecieve.do?type=db">받은 메일함</a>
	                <a class="collapse-item" href="emailSentMail.do">보낸 메일함</a>
	            </div>
	        </div>
	    </li>
	
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
	            aria-expanded="true" aria-controls="collapseUtilities">
	            <i class="fas fa-fw fa-wrench"></i>
	            <span>calendar</span>
	        </a>
	        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
	            data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <a class="collapse-item" href="calendar.do">일정</a>
	            </div>
	        </div>
	    </li>
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
	            aria-expanded="true" aria-controls="collapseUtilities">
	            <i class="fas fa-fw fa-wrench"></i>
	            <span>커뮤니티</span>
	        </a>
	        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
	            data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <h6 class="collapse-header">Custom Utilities:</h6>
	                <a class="collapse-item" href="utilities-color.html">Colors</a>
	                <a class="collapse-item" href="utilities-border.html">Borders</a>
	                <a class="collapse-item" href="utilities-animation.html">Animations</a>
	                <a class="collapse-item" href="utilities-other.html">Other</a>
	            </div>
	        </div>
	    </li>
	    <!-- Nav Item - Utilities Collapse Menu -->
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
	            aria-expanded="true" aria-controls="collapseUtilities">
	            <i class="fas fa-fw fa-wrench"></i>
	            <span>출퇴근</span>
	        </a>
	        <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
	            data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	                <a class="collapse-item" href="commuteSelectList.do">commute</a>
	            </div>
	        </div>
	    </li>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider">
	
	</ul>
	<!-- End of Sidebar -->
</body>
</html>