function adicionarItem(id) {
	
	var element = $("#add_" + id);
	element.attr("style", "display:none");
	
	var element = $("#remove_" + id);
	element.attr("style", "display:block");
	
}

function removerItem(id) {
	
	var element = $("#add_" + id);
	element.attr("style", "display:block");
	
	var element = $("#remove_" + id);
	element.attr("style", "display:none");
}