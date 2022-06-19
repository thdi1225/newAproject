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
			<label for="section_id" class="col-sm-2 col-form-label">id</label>
			<input id="section_id" name="section_id" type="text" class="col-sm-7 input">
		</div>
		<div class="form-group">
			<label for="section_name" class="col-sm-2 col-form-label">name</label>
			<input id="section_name" name="section_name" type="text" class="col-sm-7 input">
		</div>
		<div class="form-group">
			<label for="section_sort" class="col-sm-2 col-form-label">sort</label>
			<input id="section_sort" name="section_sort" type="text" class="col-sm-7 input">
		</div>
		<div class="form-group text-right">
			<input type="button" class="table-btn" onclick="sectionInsert()" value="Sign Up">
		</div>
	</div>
	<script type="text/javascript">
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