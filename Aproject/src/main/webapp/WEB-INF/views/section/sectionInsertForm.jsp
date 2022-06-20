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
	<hr>
	<div class="border rounded p-3" align="center">
		<div class="form-group row">
			<label for="section_id" class="col-sm-2 col-form-label">부서코드</label>
			<input id="section_id" name="section_id" type="number" class="col-sm-5 input">
		</div>
		<hr>
		<div class="form-group row">
			<label for="section_name" class="col-sm-2 col-form-label">부서명</label>
			<input id="section_name" name="section_name" type="text" class="col-sm-5 input">
		</div>
		<hr>
		<div class="form-group row">
			<label for="section_sort" class="col-sm-2 col-form-label">부서순서</label>
			<input id="section_sort" name="section_sort" type="number" class="col-sm-5 input">
		</div>
		<hr>
		<div class="group text-right">
			<input type="button" class="table-btn" onclick="sectionUpdateCheck()" value="등록">
		</div>
	</div>
	<script type="text/javascript">
		function sectionUpdateCheck(){
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