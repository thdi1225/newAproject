<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/all.css" rel="stylesheet">
<link href="css/mail.css" rel="stylesheet">
</head>
<body>
	<div align="center">
		<form action="emailSentMail.do" method="post">
			검색 : <input type="text" id="search" name="search">
			<button type="submit" class ="btn-dark">검색</button>
		</form>
		<table class="table">
			<thead>
				<tr>
					<th><input type="checkbox" id="allCheck"></th>
				    <th class="span"><input type="button" id="selectDelete" value="선택삭제" class="table-btn"></th>
				    <th></th>
				    <th></th>
				    <th></th>
				    <th></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${emails}" var="email" varStatus = "status">
					<tr id="detailEmail">
						<td>
							<input type="hidden" id="emailId" value=${email.emailId}>
							<input type="checkbox" id="oneCheck">
						</td>
						<td>${email.emailTo}</td>
						<td style="text-align:right;"><span class="label pull-right">Email</span></td>
						<td style="text-align:left;	width:30%">${email.emailTitle}</td>
						<td><fmt:formatDate value="${email.emailDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td><input type="button" value="삭제" id="deleteEmail" class="table-btn"></td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
		<div style="display: block; text-align: center;">		
			<c:if test="${paging.startPage != 1 }">
				<a href="emailSentMail.do?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<a href="emailSentMail.do?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<a href="emailSentMail.do?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a>
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
		
        var delCols = document.querySelectorAll("#deleteEmail");
        for (var i = 0; i < delCols.length; i++) {
            delCols[i].addEventListener("click", delEmail);
        }

        function delEmail(e) {
            let emailId = e.target.parentElement.parentElement.children[0].children[0].value; //id값이 있는 위치!!
            e.target.parentElement.parentElement.remove();
            $.ajax({
            	url:"emailDelete.do",
            	type:"post",
            	data:{"emailId":emailId,"toFrom":"from"},
            	dataType:"json",
            	success:function(res){
            		location.reload();
  			  		loadingPageOff();
            	}
            })
            e.stopPropagation();
        }
		
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
            let id = this.children[0].children[0].value;
            
            let frmId = document.createElement('form');

            let idObj;
            idObj = document.createElement('input');
            idObj.setAttribute('type','hidden');
            idObj.setAttribute('name','emailId');
            idObj.setAttribute('value',id);
            
            let toFromObj;
            toFromObj = document.createElement('input');
            toFromObj.setAttribute('type','hidden');
            toFromObj.setAttribute('name','toFromObj');
            toFromObj.setAttribute('value','1');

            frmId.appendChild(idObj);
            frmId.appendChild(toFromObj);
            frmId.setAttribute('method','post');
            frmId.setAttribute('action','emailDetail.do');
            document.body.appendChild(frmId);
            frmId.submit();
        }

	    //선택삭제 버튼 누르면 체크한거 삭제
	    document.querySelector('#selectDelete').addEventListener('click',e => {
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
	            data : {"emailId":JSON.stringify(cbarr),"toFrom":"f"},
	            dataType : "json",
	            success : function(res){
	            	location.reload();
	                console.log("삭제완료")
	            },
	            error : function(){
	                alert("메일을 선택해주세요.")
	            }
	
	        })
	    })
	</script>
</body>
</html>