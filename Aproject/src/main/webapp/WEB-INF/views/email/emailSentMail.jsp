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
<style type="text/css">
	tbody tr:hover{
		background-color : blue;
		color:white;
	}
</style>
</head>
<body>
	<div align="center">
		<input type="button" value="선택 삭제" id="selectDelete">
		<table border="1">
			<thead>
				<tr>
					<th width="100"><input type="checkbox" id="allCheck"></th>
					<th width="100">No.</th>
					<th width="200">받은 사람</th>
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
						<td>${email.emailTo}</td>
						<td>${email.emailTitle}</td>
						<td><fmt:formatDate value="${email.emailDate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
						<td><input type="button" value="삭제" id="deleteEmail"></td>
					</tr>
				</c:forEach>
				
			</tbody>
		</table>
	</div>
	<script type="text/javascript">
		
        var delCols = document.querySelectorAll("#deleteEmail");
        for (var i = 0; i < delCols.length; i++) {
            delCols[i].addEventListener("click", delEmail);
        }

        function delEmail(e) {
            let emailId = e.target.parentElement.parentElement.children[0].children[0].value; //id값이 있는 위치!!
            let param = 'emailId='+emailId+'&toFrom=from';
            e.target.parentElement.parentElement.remove();
            fetch('emailDelete.do',{
            	method : 'post',
  			  	headers : {'Content-Type':'application/x-www-form-urlencoded'},
  			  	body : param
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
	            data : "emailId="+JSON.stringify(cbarr),
	            dataType : "json",
	            success : function(res){
	                console.log(res)
	            },
	            error : function(){
	                console.log("실패")
	            }
	
	        })
	    })
	</script>
</body>
</html>