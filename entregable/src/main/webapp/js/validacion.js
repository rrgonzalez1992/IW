
window.onload=generarEvento;

function validacion() {

	// uso de DOM standard a nivel de javascript 
	
	var isbn= document.getElementById("isbn");
	var miformulario=document.getElementById("formularioInsercion");
	
		if(isbn.value==""){
			
				alert("datos no validos");
				return false;
				
		}else{

		 		miformulario.submit();

		}
}

function generarEvento() {

	// genera el evento onsubmit a nivel de formulario de forma no intrusiva
	var formularioInsercion= document.getElementById("formularioInsercion");
	formularioInsercion.onsubmit= function () {

		 validacion();
		 return false;
	
	}

	
}