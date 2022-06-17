<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="group">
		<label for="section_id" class="label">id</label>
		<input id="section_id" name="section_id" type="text" class="input">
	</div>
	<div class="group">
		<label for="section_name" class="label">name</label>
		<input id="section_name" name="section_name" type="text" class="input">
	</div>
	<div class="group">
		<label for="section_sort" class="label">sort</label>
		<input id="section_sort" name="section_sort" type="text" class="input">
	</div>
	<div class="group">
		<input type="button" class="button" onclick="sectionInsert()" value="Sign Up">
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