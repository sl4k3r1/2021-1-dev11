/*js/cachorro.js*/
function cachorro(){
	var som = new Audio('mp3/latido.mp3');
	som.play();
	
	
	
}
// atribui via JS a funcao ao evento de mouseover
var logotipo = document.querySelectorAll('.logo')[0];
// nesse momento eu atribuo apenas o NOME da funcao ao evento
// SEM OS PARENTESES - evitando que ela seja executada.
logotipo.onmouseover = cachorro;

