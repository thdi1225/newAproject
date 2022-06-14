<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div align="center">
		<div>
			<h1>자유게시판</h1>
		</div>
		<div>
			<form id="frm">
				<select id="key" name="key">
					<option value="2">작성자</option>
					<option value="3">제목</option>
					<option value="4">내용</option>
				</select>&nbsp; <input type="text" id="val" name="val">&nbsp; <input
					type="button" onclick="search2();" value="검색">
			</form>
		</div>
		<br />
		<div>
			<table border="1" id="ta">
				<thead>
					<tr>
						<th width="100">글번호</th>
						<th width="150">작성자</th>
						<th width="250">제목</th>
						<th width="150">작성일자</th>
						<th width="100">조회수</th>
						<th width="200">첨부파일</th>
					</tr>
				</thead>
				<tbody id="tb">
					<c:forEach items="${list }" var="board">
						<tr>
							<td align="center">${board.board_id }</td>
							<td align="center">${board.board_writer }</td>
							<td>${board.board_title }</td>
							<td align="center">${board.board_date }</td>
							<td align="center">${board.hit }</td>
							<td>${board.fileName }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br /> <br>    
		<!-- 페이지처리 -->
		<div id="pageForm">
			 <c:if test="${startPage != 1}">           
			 <a href='BoardListAction.bo?page=${startPage-1}'>[ 이전 ]</a>       
			 </c:if>
			<c:forEach var="pageNum"begin="${startPage}"end="${endPage}">          
			  <c:if test="${pageNum == spage}">${pageNum}&nbsp;</c:if> 
			<c:if test="${pageNum != spage}"> 
			 <a href='BoardListAction.bo?page=${pageNum}'>${pageNum}&nbsp;</a>
			 </c:if>     
			   </c:forEach>
			 <c:if test="${endPage != maxPage }">
			  <a href='BoardListAction.bo?page=${endPage+1 }'>[다음]</a>    
			 </c:if>
			    
		</div>

		<div>
			<button type="button" onclick="location.href='boardInputForm.do'">글쓰기</button>
		</div>
	</div>
	<script type="text/javascript">
	function search() {
		let fields = ['board_id','board_writer','board_title','board_date','hit','fileName'];
		let allTr = document.querySelectorAll('tbody>tr');
		let k = document.getElementById("key").value;  //key 값
		let v = document.getElementById("val").value;  //val 값

		allTr.forEach(function (tr) {
		   	 tr.remove();
		    });
		
		let list = document.querySelector('tbody');
		
		fetch('ajaxSearchList.do',{
			 method: 'POST',
			 headers: {
				'Content-Type' : 'application/x-www-form-urlencoded', 
			 },
			 body : 'key='+k+'&val='+v
			})
		 .then(response => response.json())  //json type으로 결과 받음
		 .then(data => {
			 console.log(data);
			 data.forEach(d => {  //json data를 한행식 읽음
			 let tr = document.createElement('tr'); //<tr> 태그 생성
			 fields.forEach(f => {       //한행의 데이터 에서
		       let td = document.createElement('td'); //<td>를 만들면서
		       td.innerHTML = d[f];  //필드값과 일치 키값에서 데이터를 가져와서 td에 넣고
		       tr.appendChild(td);    //tr에 td를 추가
			 })
				 list.appendChild(tr);  //그리고 tbody에 tr을 추가한다.
			 })
		 })
	}
	
	function search2() {
		$.ajax({
			url : "ajaxSearchList.do",
			type : "post",
			data : {"key":$("#key").val(),"val":$("#val").val()},
			dataType : "json",
			success : function(data){
				htmlConvert(data);
				},
			error : function(){
				//실패시 구현
			}
		});	
	}
	
	function htmlConvert(data){
		$("tbody").remove();  //tbody 제거
		let tb = $("<tbody />");
		$.each(data, function(index,item){
			let tr = $("<tr />").append(
					$("<td align='center' />").text(item.board_id),
					$("<td align='center' />").text(item.board_writer),
					$("<td />").text(item.board_title),
					$("<td align='center' />").text(item.board_date),
					$("<td align='center' />").text(item.hit),
					$("<td />").text(item.fileName)
			);
			tb.append(tr);
		});
		$("#ta").append(tb);
	}
</script>
</body>
</html>