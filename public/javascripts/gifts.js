function manageItem(idGift, idPerfil, actionName) {
	
	if(actionName == 'Adicionar') {
		var element = $("#add_" + idGift);
		element.attr("style", "display:none");
	
		var element = $("#remove_" + idGift);
		element.attr("style", "display:block");
	
	} else {
		var element = $("#add_" + id);
		element.attr("style", "display:block");

		var element = $("#remove_" + id);
		element.attr("style", "display:none");	
	}
	
	$.get("/GenerateQuestion/manageGift/" + idGift, { action : encodeURIComponent(actionName), gift : encodeURIComponent(idGift), perfil : encodeURIComponent(idPerfil), authenticity_token : encodeURIComponent(AUTH_TOKEN) });
		
}

function removerItem(id) {
	
	
}

function avisaUsuario() {
	
	alert("Sistema ainda em construção, em alguns dias estaremos online!");
}