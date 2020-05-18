$(document).ready(function(){
	$("#input_imgs").on("change", handleImgFileSelect);
	
});

var sel_files = [];

var MAX_WIDTH = 400;
var MAX_HEIGHT = 400;


function handleImgFileSelect(e){
	
	$('.img_box').empty();
	
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	var index = 0;
	filesArr.forEach(function(f){
		
		sel_files.push(f);
		
		var reader = new FileReader();
		reader.onload = function(e){
			
			$("body").append('<img src="" id="temp_img" style="display:none;" />');
			$("#temp_img").attr("src", e.target.result);
			
			width = $("#temp_img").width();
			height = $("#temp_img").height();
			  
			if(width > height){
				if(width > MAX_WIDTH){
					height *= MAX_WIDTH / width;
					width = MAX_WIDTH;
				}
			} else{
				if(height > MAX_HEIGHT){
					width *= MAX_HEIGHT / height;
					height = MAX_HEIGHT;
				}
			}
			
			var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction(" + index + ")\" id=\"img_id_" + index + "\" name=\"imgs\"><img width=" + width + " height=" + height + " src=\"" + e.target.result + "\" data-file'"+f.name+"'>" ;
			$(".img_box").append(html);
			
			var img_id = "#img_id_" + index;
			
			var width = $(img_id).children("img").attr("width");
	        var height = $(img_id).children("img").attr("height");
	        
	        $("#temp_img").remove();
	        
			index++;
		}
		reader.readAsDataURL(f);
		
	});
}
		
/*function deleteImageAction(index){
	sel_files.splice(index, 1);
	
	var img_id = "#img_id_" + index;
	$(img_id).remove();
	
}
*/