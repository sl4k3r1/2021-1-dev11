/* js/produto.js */

function troca (imagem, raca){
	var grande = document.querySelectorAll('.album img')[0];
	var nome = document.querySelectorAll('.album h2')[0];
	grande.src = imagem;
	nome.innerHTML = raca;
	
}
