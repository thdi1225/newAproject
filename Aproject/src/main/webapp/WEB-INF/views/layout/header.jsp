<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Topbar -->
	<nav
		class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
		<!-- Sidebar Toggle (Topbar) -->
		<button id="sidebarToggleTop"
			class="btn btn-link d-md-none rounded-circle mr-3">
			<i class="fa fa-bars"></i>
		</button>

		<!-- Topbar Navbar -->
		<ul class="navbar-nav ml-auto">

			<!-- Nav Item - Search Dropdown (Visible Only XS) -->
			<li class="nav-item dropdown no-arrow d-sm-none"><a
				class="nav-link dropdown-toggle" href="#" id="searchDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
			</a> <!-- Dropdown - Messages -->
				<div
					class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
					aria-labelledby="searchDropdown">
					<form class="form-inline mr-auto w-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-primary" type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>
				</div></li>

			<!-- Nav Item - Messages !!!!!!!!!!-->
			<c:if test="${not empty memberVO.member_mail_email}">
				<li class="nav-item dropdown no-arrow mx-1"><a
					class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <!-- Counter - Messages -->
						<span class="badge badge-danger badge-counter">N</span>
				</a> <!-- Dropdown - Messages -->
					<div id ="dropdownMsg"
						class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
						aria-labelledby="messagesDropdown">
						<h6 class="dropdown-header">Message Box</h6>
					</div>
					
					</li>
					<div class="topbar-divider d-none d-sm-block"></div>
			</c:if>


			<!-- Nav Item - User Information -->
			<li class="nav-item dropdown no-arrow"><a
				class="nav-link dropdown-toggle" href="#" id="userDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <span
					class="mr-2 d-none d-lg-inline text-gray-600 small">${memberVO.member_name}</span> <img class="img-profile rounded-circle"
					src="img/undraw_profile.svg">
			</a> <!-- Dropdown - User Information -->
				<!-- <div
					class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
					aria-labelledby="userDropdown">
					<a class="dropdown-item" href="#"> <i
						class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> Profile
					</a> <a class="dropdown-item" href="#"> <i
						class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> Settings
					</a> <a class="dropdown-item" href="#"> <i
						class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> Activity
						Log
					</a>
					<div class="dropdown-divider"></div>
					<a class="dropdown-item" href="#" data-toggle="modal"
						data-target="#logoutModal"> <i
						class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
						Logout
					</a>
				</div>-->
			</li> 
			<li class="login-btn-li"><a class="login-btn" href="myPage.do" style="margin-right: 10px;">my Page</a>
			<li class="login-btn-li"><a class="login-btn" href="logout.do">logout</a>
			</li>
		</ul>

	</nav>
	<!-- End of Topbar -->
	<script>
	
		function makeDiv(emailTitle, emailFrom){
			let a = document.createElement('a');
			a.setAttribute('class','dropdown-item d-flex align-items-center');
			a.setAttribute('href','#');
			a.setAttribute('id','amsg');
			
			let dropdownDiv = document.createElement('div');
			dropdownDiv.setAttribute('class','dropdown-list-image mr-3');
			let img = document.createElement('img');
			
			img.setAttribute('class',"rounded-circle");
			let ran = Math.floor(Math.random()*2+1);
			img.setAttribute('src',"img/undraw_profile_"+ran+".svg");
			img.setAttribute('alt',"...");
			dropdownDiv.append(img);
			let statusDiv = document.createElement('div');
			statusDiv.setAttribute('class','status-indicator bg-success');
			dropdownDiv.append(statusDiv);
			a.append(dropdownDiv);
			
			let fontDiv = document.createElement('div');
			fontDiv.setAttribute('class',"font-weight-bold");
			
			let div = document.createElement('div');
			div.setAttribute('class', 'text-truncate');
			div.innerText = emailTitle + "";
			fontDiv.append(div);
			div = document.createElement('div');
			div.setAttribute('class','small text-gray-500');
			div.innerText = emailFrom + "";
			fontDiv.append(div);
			a.append(fontDiv);
			$("#dropdownMsg").append(a);
		}
		
		function makeFin(){
			let a = document.createElement("a");
			a.setAttribute('class','dropdown-item text-center small text-gray-500');
			a.setAttribute('href','emailRecieve.do');
			a.innerText='Read More Messages';
			a.setAttribute('id','amsg');
			$("#dropdownMsg").append(a);
		}
		document.getElementById('messagesDropdown').addEventListener('click', function(e) {
			$.ajax({
				url : "emailSelectFive.do",
				type : "post",
				dataType : "json",
				success : function(res) {
					let li =document.querySelectorAll("#amsg");
					li.forEach(e=>{
						console.log(e);
						e.remove();
					})
					$.each(res, function(idx, item) {
						console.log(item);
						makeDiv(item.emailTitle,item.emailFrom);
					})
					makeFin();
				}
			})
		})
	</script>
</body>
</html>