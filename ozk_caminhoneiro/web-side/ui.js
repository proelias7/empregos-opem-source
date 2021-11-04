$(function(){
	init();

	var actionContainer = $("#actionmenu");

	window.addEventListener('message',function(event){
		var item = event.data;

		if (item.showmenu){
			actionContainer.slideDown(800);
		}

		if (item.hidemenu){
			actionContainer.slideUp(400);
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			if (actionContainer.is(":visible")){
				sendData("ButtonClick","fechar")
			}
		}
	};
})

function init() {
	$(".menuoption").each(function(i,obj){
		if ($(this).attr("data-action")){
			$(this).click(function(){
				var data = $(this).data("action"); 
				sendData("ButtonClick",data); 
			})
		}
	});
}

function sendData(name,data){
	$.post("http://ozk_caminhoneiro/"+name,JSON.stringify(data),function(datab){
		if (datab != "ok"){
			console.log(datab);
		}
	});
}