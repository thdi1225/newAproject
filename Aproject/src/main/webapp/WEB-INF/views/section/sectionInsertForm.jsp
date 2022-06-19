<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<small class="float-right text-underline-bold">부서관리 > 부서등록</small>
		<h2 class="text-title">
			부서등록
		</h2>
	</div>
	<div class="border rounded p-3">
		<div class="form-group">
			<label for="section_id" class="col-sm-2 col-form-label">부서코드</label>
			<input id="section_id" name="section_id" type="text" class="col-sm-7 input">
		</div>
		<div class="form-group">
			<label for="section_name" class="col-sm-2 col-form-label">부서명</label>
			<input id="section_name" name="section_name" type="text" class="col-sm-7 input">
		</div>
		<div class="form-group">
			<label for="section_sort" class="col-sm-2 col-form-label">부서순서</label>
			<input id="section_sort" name="section_sort" type="text" class="col-sm-7 input">
		</div>
		<div class="form-group text-right">
			<input type="button" class="table-btn" onclick="memberUpdateCheck()" value="등록">
		</div>
	</div>
	<script type="text/javascript">
		function memberUpdateCheck(){
			if ($.trim($("#section_id").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("부서코드를 입력하세요.");
				$("#section_id").focus();
			}else if($.trim($("#section_name").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("부서명을 입력하세요.");
				$("#section_name").focus();
			}else if($.trim($("#section_sort").val()) == "") {
				toastr.options = { "positionClass": "toast-top-center" }
				toastr["error"]("부서순서를 입력하세요.");
				$("#section_sort").focus();
			}else{
				sectionInsert();
			}
		}
	
		function sectionInsert(){
			$.ajax({
				url:"sectionInsert.do",
				data: {
					"section_id" : $("#section_id").val(),
					"section_name" : $("#section_name").val(),
					"section_sort" : $("#section_sort").val()
				},
				success:function(result){
					toastr.info("부서가 등록되었습니다.");
					location.href="sectionSelectList.do";
				}
			});
		}
	</script>
</body>
</html>