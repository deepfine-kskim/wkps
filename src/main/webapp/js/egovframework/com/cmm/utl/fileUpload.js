/*var $returnUpload;
var $this;
var frmUpload;*/
$(document).ready(function() {
	/*frmUpload = $("<form></form>", {
		action : "/cmm/fms/upload.do",
		target : "frameUpload",
		method : "post",
		enctype : "multipart/form-data",
		id : "uploadForm"
	}).appendTo("body").hide();*/
	
	

	$("body").on("change", ".dev-input-file", function(e) {
		/*$this = $(this);
		frmUpload.append($this.clone()).submit();
		$.blockUI();*/
		
		var filename = $(this).val();
    	var ext = filename.substring(filename.lastIndexOf('.')+1);
    	
    	if($.inArray(ext.toUpperCase(), ['JPG', 'JPEG', 'MP4', 'MP3', 'PNG']) == -1) {
    		alert('업로드가 불가능한 확장자 파일이 포함되어 있습니다.\n\n업로드 가능한 확장자\n[png, jpg, jpeg, mp4, mp3]');
    		return false;
    	}
		
		var $this = $(this);
		var formData = new FormData();
		formData.append($(this).attr("name"), $(this)[0].files[0]);
		$.ajax({
			url: "/cmm/fms/upload.do",
			processData: false,
			contentType: false,
			data: formData,
			type: "POST",
 			dataType: "json",
 			success : function(data) {
				if(data.result[0].atchFileNo != null && data.result[0].atchFileNo > 0) {
					var url = $(location).attr("host") + data.result[0].fileStreCours + data.result[0].streFileNm + "." + data.result[0].fileExtsn;
					var $parent = $this.closest(".dev-group");
					var $element = '<a href="' + url  + '" target="_blank" class="text-danger dev-file-link" data-filetype="'+ data.result[0].fileType +'">' + data.result[0].orignlFileNm + '</a> ('+ getfileSize(data.result[0].fileMg) +')';
					var $input = $("<input />", {
						type : "hidden",
						name : "file",
						value : data.result[0].atchFileNo}).addClass("dev-upload-file-num");
					
					$parent.find(".dev-file-wrap").append($element).append($input);
				} else {
					alert("파일 업로드 중 에러가 발생하였습니다.");
				}
				$this.remove();
 			},
 			error : function(){
 				alert("파일 업로드 중 에러가 발생하였습니다.");
 				$this.remove();
 			}
		});

	});

	/*$returnUpload = function(r) {
		r = $.parseJSON(r);
			if (r.atchFileNo != null && r.atchFileNo > 0) {
				var url = $(location).attr("host") + r.fileStreCours + r.streFileNm + "." + r.fileExtsn;

				var $parent = $this.closest(".dev-group");
				var $element = '<a href="' + url  + '" target="_blank" class="text-danger dev-file-link" data-filetype="'+ r.fileType +'">' + r.orignlFileNm + '</a> ('+ getfileSize(r.fileMg) +')';
				var $input = $("<input />", {
					type : "hidden",
					name : "file",
					value : r.atchFileNo}).addClass("dev-upload-file-num");

				$parent.find(".dev-file-wrap").append($element).append($input);
			} else {
				alert("파일 업로드 중 에러가 발생하였습니다.");
			}

			$this.remove();
			frmUpload.find(".dev-input-file").remove();
			$.unblockUI();
	};*/
});

function getfileSize(x) {
	var s = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'];
	var e = Math.floor(Math.log(x) / Math.log(1024));
	return (x / Math.pow(1024, e)).toFixed(2) + " " + s[e];
};

