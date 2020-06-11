$(document).ready(function(){
	$("#upload").on("change", handleImgFileSelect);
	
});

function handleImgFileSelect(e){
	var file = Array.prototype.slice.call(e.target.files);
	
		var reader = new FileReader();
		reader.onload = function(e){
			$("#pImg").attr('src', e.target.result);
		}
		reader.readAsDataURL(e.target.files[0]);
}