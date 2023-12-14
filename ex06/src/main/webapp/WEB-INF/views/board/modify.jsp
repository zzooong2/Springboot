<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Board Modify/Delete</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Modify/Delete
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <form>
                                <div class="form-group">
						          <label>BNO</label> 
						          <input class="form-control" name="bno" readonly="readonly" value='<c:out value="${board.bno}"/>'>
				               	</div>
                        
				            	<div class="form-group">
						          <label>Title</label> 
						          <input class="form-control" name="title" value='<c:out value="${board.title}"/>'>
				               	</div>
				               	
				               	<div class="form-group">
						          <label>Content</label>
						          <textarea rows="5" cols="50" name="content" class="form-control"><c:out value="${board.content}"/></textarea>
				               	</div>
				               	
				               	<div class="form-group">
						          <label>Writer</label> 
						          <input class="form-control" name="writer" value='<c:out value="${board.writer}"/>'>
				               	</div>
				               	
				               	<button class="btn btn-default" data-oper='modify'>Modify</button>
                                <button class="btn btn-danger" data-oper='remove'>Remove</button>
                                <button class="btn btn-info" data-oper='list'>List</button>
                        </form>  
                        
                        <form role="form" action="/board/modify" methoed="post" id='formObj'>
                            <input type='hidden' name='pageNum' value = '${cri.pageNum}'>
                            <input type='hidden' name='amount' value = '${cri.amount}'>
                            <input type='hidden' name='keyword' value = '${cri.keyword}'>
                            <input type='hidden' name='type' value = '${cri.type}'>
                        </form>  
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
<div class='bigPictureWrapper'>
  <div class='bigPicture'>
  </div>
</div>

<style>
   .uploadResult {
      width:100%;
      background-color : gray;
   }
   
   .uploadResult ul{
      display : flex;
      flex-flow : row;
      justify-content : center;
      align-items: center;
   }
   
   .uploadResult ul li {
      list-style: none;
      padding: 10px;
      align-content: center;
      text-align: center;
   }
   
   .uploadResult ul li img{
      width: 100px;
   }
   
   .uploadResult ul li span {
      color.white;
   }
   
   .bigPictureWrapper {
      position: absolute;
      display: none;
      justify-content: center;
      align-items: center;
      top:0%;
      width:100%;
      height:100%;
      background-color: gray;
      z-index: 100;
      background:rbga(255, 255, 255, 0.5);
   }
   
   .bigPicture{
      position: relative;
      display : flex;
      justify-content: center;
      align-items: center;
   }
   
   .bigPicture img{
      width:600px
   }
</style>

<!-- 새로 추가하는 부분 -->
            <div class="row">
              <div class="col-lg-12">
                <div class="panel panel-default">
                
                  <div class="panel heading">Files</div>
                  <!-- /.panel heading -->
                    <div class="panel-body">
                        <div class="form-gruop uploadDiv">
                            <input type="file" naem='uploadFile' multiple="multiple">    
                        </div>
                      <div class='uploadResult'>
                        <ul>
                        </ul>
                      </div>
                    </div>
                    <!-- end panel-body -->
                </div>
                <!-- end panel-body -->
              </div>
              <!-- end panel -->
            </div>
            <!-- /.row -->
            
<script>
$(".uploadResult ul").on("click", "button", function(e){
	
	console.log("delete file");
	
	if(confirm("Remove this file?")) {
		var targetLi = $(this).closest("li");
		targetLi.remove();
	}
	
})

$(document).ready(function() {
	(function() {
		
		var bno = '<c:out value="${board.bno}"/>';
		
		$.getJSON("/board/getAttachList", {bno:bno}, function(arr) {

		    console.log(arr);
		    
            var str = "";
		    
		    $(arr).each(function(i, attach) {
		    	 
		    	/* image type */
				if(attach.fileType) {
					   var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
					   
					   str += "<li data-path='" + attach.uploadPath + 
					          "' data-uuid='" + attach.uuid + 
					          "' data-filename='" + attach.fileName +
					          "'data-type='" + attach.fileType + "' ><div>";
					   str += "<span>" + attach.fileName + "</span>";
				       str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
			           str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
					   str += "<img src='/display?fileName=" + fileCallPath + "'>";
					   str += "</div>";
					   str + "</li>";
					   
				    } else {	
				         
				       str += "<li data-path='" + attach.uploadPath + 
				                "' data-uuid='" + attach.uuid + 
				                "' data-filename='" + attach.fileName + 
				                "' data-type='" + attach.fileType + 
				                "' ><div>";
				       str += "<span>" + attach.fileName + "</span><br/>";
				       str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image' "
				       str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
					   str += "<img src='/resource/img/attach.png'>";
					   str += "</div>";
					   str + "</li>";
				    }
			   });
		       $(".uploadResult ul").html(str);
		    	
		    }); // end getjson
	  })(); // end function
	 
});
		
</script>
            
<script>

$(document).ready(function() {
	
	var formObj = $("form");

	$('.btn').click(function(e) {
		
	    e.preventDefault();	
		
	    var operation = $(this).data("oper");
	    
	    console.log(operation);
	    
	    if(operation === 'list') {
	    	
	    	self.location ="/board/list"
	    	var pageNumTag = $("input[name='pagenum']").clone();
	    	var amountTag = $("input[name='amount']").clone();
	    	var keywordTag = $("input[name='keyword']").clone();
	    	var typeTag = $("input[name='type']").clone();
	    	
	    	
	    }else if (operation = 'remove') {
	    	formObj.attr("action","/board/remove")
	    	.attr("method","post");
	    	formObj.submit();
	    	
	    }else if (operation = 'modify') {
	    	
	    	console.log("submit clicked");
	    	
	    	var str = "";
	    	
	    	$(".uploadResult ul li").each(function(i, obj){
				
				
				var jobj = $(obj);
				
				console.dir(jobj);

				str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
				str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
				
			});
			formObj.append(str).submit();
	    }
	    
	    formObj.submit();
	    
	});
	
})

</script>


<script>

$(document).ready(function (e) {
	
        function showUploadResult(uploadResultArr) {
		
		if(!uploadResultArr || uploadResultArr.length == 0){ return;}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj) {
			
			/* image type */
			if(obj.image) {
				   var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				   str += "<li data-path='" + obj.uploadPath + "'";
				   str +=" data-uuid='" + obj.uuid + 
				        "' data-filename='" + obj.fileName + 
				        "' data-type='" + obj.image + "'"
				   str +" > <div>";
				   str += "<span>" + obj.fileName + "</span>";
				   str += "<button type='button' data-file=\'" + fileCallPath + "\' "
				   str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>"
				   str += "<img src='/display?fileName=" + fileCallPath + "'>";
				   str += "</div>";
				   str + "</li>";
				   
			    } else {	
			       var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
			         var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
			         
			       str += "<li "
			       str += "data-path='" + obj.uploadPath + 
			            "' data-uuid='" + obj.uuid + 
			            "' data-filename='" + obj.fileName + 
			            "' data-type='" + obj.image + "' ><div>";
			       str += "<span>" + obj.fileName + "</span>";
				   str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' "
				   str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				   str += "<img src='/resource/img/attach.png'></a>";
				   str += "</div>";
				   str + "</li>";
			    }
		});
        uploadUL.append(str);
		
	}
	
    var formObj = $("#formObj");
	
	$("button[type='submit']").on("click", function(e) {
		
		e.preventDefault();
		
		console.log("submit clicked");
		
		var str = "";
		
		$(".uploadResult ul li").each(function(i, obj){
			
			
			var jobj = $(obj);
			
			console.dir(jobj);

			str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";
			
		});
		formObj.append(str).submit();
	});
	
	
    
    $(".uploadResult").on("click", "button", function(e) {
  	  
  	  console.log("delete file");
  	  
  	  var targetFile = $(this).data("file");
        var type = $(this).data("type");
        
        var targetLi = $(this).closest("li");
        
        $.ajax({
		      url: '/deleteFile',
		      data:{fileName: targetFile, type:type},
		      dataType:'text',
		      type:'POST',
		         success:function(result){
		           alert(result);
		           targetLi.remove();
		         }
        }); //$.ajax
    });
    
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
	 
	function checkExtension(fileName, fileSize){
	  
	  if(fileSize >= maxSize){
	    alert("파일 사이즈 초과");
	    return false;
	  }
	  
	  if(regex.test(fileName)){
	    alert("해당 종류의 파일은 업로드할 수 없습니다.");
	    return false;
	  }
	  return true;
	}
    
	  
	  $("input[type='file']").change(function(e) {
		  
		  var formData = new FormData();
		  
		  var inputFile = $("input[name='uploadFile']");
		  
		  var files = inputFile[0].files;
		  
		  for (var i = 0; i < files.length; i++) {
			  
			  if(!checkExtension(files[i].name, files[i].size) ){
				  return false;
			  }
			  formData.append("uploadFile", files[i]);
		  }
		  
		  
		  $.ajax({
		      url: '/uploadAjaxAction',
		      processData: false, 
		      contentType: false,
		      data:formData,
		      type:'POST',
		      dataType:'json',
		         success: function(result){
		           console.log(result);
		             showUploadResult(result);
		    
		         }
		    }); //$.ajax 
		  
	  });
	
});

</script>

<%@include file="../includes/footer.jsp" %>        