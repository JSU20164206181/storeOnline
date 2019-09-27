<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<img id="showImg" class="picture-thumb" src="${product.titleImg }" width="210">
	<input id="filePath" type="file" multiple="" name="titleImg"  accept="image/*" class="input-file" onchange="upload()"/>
	
	<script type="text/javascript">

	//限制只能上传图片
	function upload() {
	    var _name, _fileName, personsFile;
	    personsFile = document.getElementById("filePath");
	    _name = personsFile.value;
	    _fileName = _name.substring(_name.lastIndexOf(".") + 1).toLowerCase();
	    console.log(_name)
	    if (_fileName !== "png" && _fileName !== "jpg") {
	        alert("上传图片格式不正确，请重新上传");
	    } else {
	        document.getElementById("showImg").src = window.URL.createObjectURL(personsFile.files[0]);
	    }
	}
	</script>
</body>
</html>