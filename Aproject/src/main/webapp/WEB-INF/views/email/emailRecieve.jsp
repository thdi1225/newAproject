<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	tbody tr:hover{
		background-color : blue;
		color:white;
	}
</style>
</head>
<body>
	<div class="spinner-border" role="status" align="center" id="loading">
	  	<span class="visually-hidden"></span>
	</div>
	<div id = "con" align="center">
		<input type="button" id="refreshBtn" value="새로고침">
		<input type="button" value="선택 삭제" id="selectDelete">
		<form action="emailRecieve.do" method="post">
			검색 : <input type="text" id="search" name="search">
			<button type="submit">검색</button>
		</form>
		<table border="1" id="tb">
			<thead>
				<tr>
					<th width="100"><input type="checkbox" id="allCheck"></th>
					<th width="100">No.</th>
					<th width="200">보낸사람</th>
					<th width="300">제목</th>
					<th width="200">전송 시간</th>
					<th width="100">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emails}" var="email" varStatus = "status">
					<tr id="detailEmail">
						<td>
							<input type="hidden" id="emailId" value=${email.emailId}>
							<input type="checkbox" id="oneCheck">
						</td>
						<td>${fn:length(emails) - status.index}</td>
						<td>${email.emailFrom}</td>
						<td>${email.emailTitle}</td>
						<td><fmt:formatDate value="${email.emailDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td><input type="button" value="삭제" id="deleteEmail"></td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<div style="display: block; text-align: center;">		
			<c:if test="${paging.startPage != 1 }">
				<a href="emailRecieve.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="emailRecieve.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a href="emailRecieve.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
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
  			  		location.reload();
  			  		loadingPageOff();
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
        			console.log("data가 없다...");
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
                            console.log('false');
                            document.querySelector('#allCheck').checked=false;
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
	            	location.reload();
	                loadingPageOff();
	            },
	            error : function(){
	            	loadingPageOff();
	                console.log("실패")
	            }
	
	        })
	    })
	</script>
    
</body>
</html>