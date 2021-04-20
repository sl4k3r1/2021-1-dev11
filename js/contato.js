/* js/contato.js */
function valida() {
	var nome = document.querySelectorAll('#nome')[0];
	var email = document.querySelectorAll('#email')[0];
	var texto = document.querySelectorAll('#texto')[0];
	var erro = document.querySelectorAll('#erro')[0];
	var email_regex = /^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
	
	
	
	if (nome.value == ''){
		erro.innerHTML = 'Preencha o nome...';
		nome.focus();
		return false;
	}
	if (email.value == ''){
		erro.innerHTML = 'Preencha o email...';
		email.focus();
		return false;
	}
	if (!email_regex.test(email.value)){
		erro.innerHTML = 'Preencha o email...';
		email.focus();
		return false;
	}
	if (texto.value == ''){
		erro.innerHTML = 'Preencha a mensagem...';
		texto.focus();
		return false;
	}
	
	
	
	return true;
}


