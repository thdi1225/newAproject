<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/all.css" rel="stylesheet">
<link href="css/mail/mail.css" rel="stylesheet">

</head>
<body>
	<div>
		<small class="float-right text-underline-bold">메일관리 > 받은 메일함</small>
		<h2 class="text-title">받은 메일함</h2>
	</div>
	<hr>
	<div class="spinner-border" role="status" align="center" id="loading">
		<span class="visually-hidden"></span>
	</div>

	<div id="con" align="center">
		<form action="emailRecieve.do" method="post">
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="search" name="search"
					placeholder="이름으로 검색하실 수 있습니다." aria-label="Recipient's username"
					aria-describedby="searchButton">

				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="submit"
						id="searchButton">검색</button>
				</div>
			</div>
		</form>


		<table id="tb" class="table">
			<thead>
				<tr>
					<th><input type="checkbox" id="allCheck"></th>
					<th class="span"><input type="button" id="selectDelete"
						value="선택삭제" class="table-btn"></th>
					<th></th>
					<th></th>
					<th></th>
					<th><input type="button" id="refreshBtn" value="동기화"
						class="btn-dark"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emails}" var="email" varStatus="status">
					<tr id="detailEmail">
						<td><input type="hidden" id="emailId" value=${email.emailId}>
							<input type="checkbox" id="oneCheck"></td>
						<td>${email.emailFrom}</td>
						<td style="text-align: right;"><span class="label pull-right">Email</span></td>
						<td style="text-align: left; width: 30%">${email.emailTitle}</td>
						<td><fmt:formatDate value="${email.emailDate}"
								pattern="yyyy-MM-dd hh:mm:ss" /></td>
						<td><input type="button" value="삭제" id="deleteEmail"
							class="table-btn"></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
		<div style="display: block; text-align: center;">
			<c:if test="${paging.startPage != 1 }">
				<a
					href="emailRecieve.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
				var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a
							href="emailRecieve.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a
					href="emailRecieve.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
		

		//로딩 페이지
		var loader = document.getElementById('loading');
		var con = document.getElementById('con');
		loader.style.display="none";
		
		function loadingPageOn(){
			loader.style.display="block";
			con.style.display="none";
		}
		
		function loadingPageOff(){
			loader.style.display="none";
			con.style.display="block";
		}
		
        var delCols = document.querySelectorAll("#deleteEmail");
        for (var i = 0; i < delCols.length; i++) {
            delCols[i].addEventListener("click", delEmail);
        }

        function delEmail(e) {
            let emailId = e.target.parentElement.parentElement.children[0].children[0].value; //id값이 있는 위치!!
            e.target.parentElement.parentElement.remove();
            loadingPageOn();
            $.ajax({
            	url:"emailDelete.do",
            	type:"post",
            	data:{"emailId":emailId,"toFrom":"to"},
            	dataType:"json",
            	success:function(res){
            		swal({
						title: "삭제를 완료하였습니다.",
						icon: "success"
					}).then((willDelete) => {
						location.reload();
		  			  	loadingPageOff();
					})
            	}
            })
            
            e.stopPropagation();
        }
		
        //새로고침 페이지
        document.getElementById('refreshBtn').addEventListener('click',e=>{
        	loadingPageOn();
        	$.ajax({
        		url:'emailRecieve.do',
        		type:"POST",
        		data:{"type":"refresh"},
        		dataType:"json",
        		success:function(res){
					loadingPageOff();
					location.reload();
        		},
        		error:function(){
        			location.href='emailEmpty.do';
        		}
        	})
        })   	
        
        
        //전체선택했을 때 체크박스 개인
        document.querySelector('#allCheck').addEventListener('click',function(e){
                    let cbxs = document.querySelectorAll('#oneCheck');
                    
                    if(e.target.checked){
                        cbxs.forEach(e => {
                            e.checked = true;
                        });
                    }else{
                        cbxs.forEach(e => {
                            e.checked = false;
                        });
                    }
                })
		
        //체크박스 선택시 전체체크박스 해제
        let cbxs = document.querySelectorAll('#oneCheck');
        cbxs.forEach(e => {
                    e.addEventListener('click',function(cb){
                        if(cb.target.checked==false){
                            document.querySelector('#allCheck').checked=false;
                        }else{
                        	let flag = true;
                        	for (var i = 0; i < cbxs.length; i++) {
                                if(cbxs[i].checked==false){
                                	flag = false;
                                	break;
                                }
                            }
                        	if(flag){
                        		console.log("allcheck바꿔")
                        		document.querySelector('#allCheck').checked=true;
                        	}
                        }
                        cb.stopPropagation();
                    })
                });
		
        //tr 선택시 상세보기 페이지로
		let detCols = document.querySelectorAll("#detailEmail");
		        detCols.forEach(e => {
		            e.addEventListener("click",detEmail);
		        });
		        
        function detEmail(e){ //POST 방식으로 페이지 이동
        	console.log(this.children[0].children[0].value);
            let id = this.children[0].children[0].value;
            
            let frmId = document.createElement('form');

            let obj;
            obj = document.createElement('input');
            obj.setAttribute('type','hidden');
            obj.setAttribute('name','emailId');
            obj.setAttribute('value',id);
			
            let toFromObj;
            toFromObj = document.createElement('input');
            toFromObj.setAttribute('type','hidden');
            toFromObj.setAttribute('name','toFromObj');
            toFromObj.setAttribute('value','0');
            
            frmId.appendChild(obj);
            frmId.appendChild(toFromObj);
            frmId.setAttribute('method','post');
            frmId.setAttribute('action','emailDetail.do');
            document.body.appendChild(frmId);
            frmId.submit();
        }
		

	    //선택삭제 버튼 누르면 체크한거 삭제
	    document.querySelector('#selectDelete').addEventListener('click',e => {
	    	loadingPageOn();
	        let cbxs = document.querySelectorAll('#oneCheck');
	        let cbarr = [];
	        cbxs.forEach(cb => {
	            if(cb.checked){
	            	cbarr.push(cb.parentElement.parentElement.children[0].children[0].value);
	                cb.parentElement.parentElement.remove();
	            }
	        });
	
	        $.ajax({
	            url : "emailDelete.do",
	            type: "POST",
	            data : {"emailId":JSON.stringify(cbarr),"toFrom":"to"},
	            dataType : "json",
	            success : function(res){
	            	swal({
						title: "삭제를 완료하였습니다.",
						icon: "success"
					}).then((willDelete) => {
						location.reload();
					})
	                loadingPageOff();
	            },
	            error : function(){
	            	loadingPageOff();
	            	toastr.options = { "positionClass": "toast-top-center" }
					toastr.error("메일을 선택해 주세요.");
	            }
	
	        })
	    })
	</script>

</body>
</html>