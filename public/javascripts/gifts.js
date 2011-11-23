function manageItem(parametros) {
	
	var arr = new Array;
	
	arr = parametros.split(" ");
	
	idGift = arr[0];
	idPerfil = arr[1];
	acao = arr[2];
	
	
	
	if(acao == 'Adicionar') {
		var element = $("#add_" + idGift);
		element.attr("style", "display:none");
	
		var element = $("#remove_" + idGift);
		element.attr("style", "display:block");
	
	} else {
		var element = $("#add_" + idGift);
		element.attr("style", "display:block");

		var element = $("#remove_" + idGift);
		element.attr("style", "display:none");	
	}
	
	$.get("/GenerateQuestion/manageGift/" + idGift, { action : encodeURIComponent(acao), gift : encodeURIComponent(idGift), acao : encodeURIComponent(acao), perfil : encodeURIComponent(idPerfil), authenticity_token : encodeURIComponent(AUTH_TOKEN) });
		
}


function avisaUsuario() {
	
	alert("Sistema ainda em construção, em alguns dias estaremos online!");
}

function loadingGifts() {
	
	alert("entrei aki");
	var element = $("#question")
	element.addClass("loading_view")
}