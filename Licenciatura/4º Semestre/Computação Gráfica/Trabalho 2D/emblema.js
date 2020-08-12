// funçao que aumenta e move o nosso contexto em utilizaçao

function enter(c2d, tx, ty, sx, sy)
{
	c2d.save();
	c2d.translate(tx,ty);
	c2d.scale(sx, sy);
}

// função que restora o contexto

function leave(c2d, fs, ss)
{
	
    c2d.fillStyle = fs;
    c2d.strokeStyle = ss;
    c2d.fill();
    c2d.stroke();
    c2d.restore();
}

// funçao que restora o contexto sem dar stroke

function leave2(c2d)
{
	c2d.restore();
}

/////////////////////////////////////////////////////////

// contorno exterior do emblema
function contorno (c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.0, 0.0);
	c2d.lineTo(0.82, 0.0);
	c2d.lineTo(0.82, 0.70);
	c2d.arcTo(0.82, 0.75, 0.41, 1.0, 0.1);
	c2d.lineTo(0.41, 1.06);
	c2d.moveTo(0.0, 0.0);
	c2d.lineTo(0.0, 0.70);
	c2d.arcTo(0.0, 0.75, 0.41, 1.0, 0.1);
	c2d.lineTo(0.41, 1.06);
	c2d.moveTo(0.0, 0.0);
	c2d.closePath();
	
}

// contorno da parte onde se irao localizar as quatro riscas vermelhas
// depois de ter o contorno executa-se um clip para as riscas nao sairem do contorno definido
function contorno2 (c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.82, 0.0);
	c2d.lineTo(0.82, 0.70);
	c2d.arcTo(0.82, 0.75, 0.41, 1.0, 0.1);
	c2d.lineTo(0.41, 1.06);
	c2d.lineTo(0.05, 0.78);
	c2d.lineTo(0.82, 0.0);
	c2d.closePath();

	// riscas aparecem a partir do frame 450
	if(frame>=450){

	c2d.lineWidth = 0.001;	
	c2d.clip();	
	c2d.stroke();

	c2d.fillStyle = "#d42e12";

	c2d.translate(0.17, 0);	
	risca(c2d);
	c2d.translate(0.19, 0.1);
	risca(c2d);
	c2d.translate(0.19, -0.1);	
	risca(c2d);
	c2d.translate(0.19, 0);
	risca(c2d);
	c2d.restore();
	}
}

//////////////////////////////////////////////////////////

// contorno triangulo azul
function triangulo(c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.0, 0.0);
	c2d.lineTo(0.0, 0.70);
	c2d.arcTo(0.0, 0.75, 0.41, 1.0, 0.1);
	c2d.lineTo(0.82, 0.0);
	c2d.lineTo(0.0, 0.0);
	c2d.closePath();

}

// contorno do triangulo azul onde estao o urso e a arvore
function triangulo2 (c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.0, 0.0);
	c2d.lineTo(0.0, 0.8);
	c2d.lineTo(0.8, 0.0);
	c2d.lineTo(0.0, 0.0);
	c2d.closePath();

}

///////////////////////////////////////////////////////

// desenho das estrelas
function estrela(c2d){
	c2d.beginPath();
	c2d.moveTo(0.40, 0.00);
	c2d.lineTo(0.30, 0.30);
	c2d.lineTo(0.00, 0.30);
	c2d.lineTo(0.24, 0.47);
	c2d.lineTo(0.15, 0.77);
	c2d.lineTo(0.40, 0.60);
	c2d.lineTo(0.65, 0.77);
	c2d.lineTo(0.56, 0.47);
	c2d.lineTo(0.80, 0.30);
	c2d.lineTo(0.50, 0.30);
	c2d.lineTo(0.40, 0.00);
	c2d.closePath();
}

/////////////////////////////////////////////////////

// desenho da copa da arvore
function arvore_topo (c2d)
{
	c2d.beginPath();
	c2d.ellipse(0.5, 0.49, 0.17, 0.13,0.0,0.0, 2*Math.PI);
	c2d.closePath();
}

// tronco da mesma arvore
function arvore_tronco (c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.48, 0.61);
	c2d.lineTo(0.48, 0.97);
	c2d.lineTo(0.46, 0.98);
	c2d.lineTo(0.38, 0.99);
	c2d.lineTo(0.38, 1.00);
	c2d.lineTo(0.68, 1.00);
	c2d.lineTo(0.69, 0.99);
	c2d.lineTo(0.54, 0.98);
	c2d.lineTo(0.52, 0.97);
	c2d.lineTo(0.52, 0.61);
	c2d.lineTo(0.48, 0.61);
	c2d.closePath();
}

function maca (c2d)
{
	c2d.beginPath();
	c2d.ellipse(0.0, 0.0, 0.05, 0.05, 0, 0, 2 * Math.PI);
	c2d.closePath();
}

// desenho do urso
function urso (c2d)
{
	c2d.beginPath();

	c2d.moveTo(0.18, 0.20);
	c2d.lineTo(0.14, 0.23);
	c2d.lineTo(0.18, 0.30);
	c2d.lineTo(0.16, 0.43);
	c2d.lineTo(0.11, 0.43);
	c2d.lineTo(0.06, 0.32);
	c2d.lineTo(0.06, 0.49);
	c2d.lineTo(0.14, 0.49);
	c2d.lineTo(0.14, 0.53);
	c2d.lineTo(0.10, 0.52);
	c2d.lineTo(0.06, 0.49);
	c2d.lineTo(0.06, 0.60);
	c2d.lineTo(0.12, 0.61);
	c2d.arcTo(0.18, 0.72, 0.21, 0.75, 0.2);
	c2d.lineTo(0.20, 0.83);
	c2d.arcTo(0.22, 0.87, 0.27, 0.90, 0.2);
	c2d.lineTo(0.28, 0.93);
	c2d.lineTo(0.27, 0.97);
	c2d.lineTo(0.32, 0.97);
	c2d.lineTo(0.32, 0.93);
	c2d.lineTo(0.34, 0.97);
	c2d.lineTo(0.39, 0.97);
	c2d.arcTo(0.35, 0.85, 0.39, 0.80, 0.1);
	c2d.lineTo(0.44, 0.80);
	c2d.arcTo(0.46, 0.78, 0.44, 0.75, 0.05);
	c2d.lineTo(0.42, 0.72);
	c2d.lineTo(0.42, 0.67);
	c2d.arcTo(0.30, 0.55, 0.34, 0.38, 0.3);
	c2d.lineTo(0.38, 0.28);
	c2d.lineTo(0.33, 0.28);
	c2d.lineTo(0.28, 0.23);
	c2d.lineTo(0.22, 0.24);
	c2d.closePath();

}

/////////////////////////////////////////////////////

// desenho de uma risca vermelha que vai aumentando ate um tamanho final
function risca (c2d)
{
	if(frame>450){
		c2d.beginPath();
		c2d.fillRect(0, 0, 0.08, x);
		c2d.closePath();
		if(x<=1.0){
			x+=0.0015;
		}
	}
}
	

/////////////////////////////////////////////////////

// funçao que executa o desenho final
function mydraw(c2d) {
	c2d.strokeStyle = "transparent"; 

	// contornos principais
	enter(c2d, 50, 0, 500, 500);
		contorno(c2d);
	leave(c2d, "#f7d117", c2d.strokeStyle);

	enter(c2d, 60, 10, 475, 475);
		contorno(c2d);
	leave(c2d, "white", c2d.strokeStyle);
	
	
	// contorno dois triangulos
	enter(c2d, 60, 10, 475, 475);
		triangulo(c2d);
	leave(c2d, "#171796", c2d.strokeStyle);

	enter(c2d, 115, 65, 260, 260);
		triangulo2(c2d);
	leave(c2d, "white", c2d.strokeStyle);


	//desenho da arvore e das respetivas maças que aparecem a partir do frame 350
	enter(c2d, 52, 0, 200, 199);
		arvore_topo(c2d);
	leave(c2d, "#009959", c2d.strokeStyle);

	enter(c2d, 52, 0, 200, 200);
		arvore_tronco(c2d);
	leave(c2d, "#703824", c2d.strokeStyle);

	if(frame>350){
	enter(c2d, 131, 90, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	}

	if(frame>350){
	enter(c2d, 146, 84, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	}

	if(frame>380){
	enter(c2d, 156, 95, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	}

	if(frame>380){
	enter(c2d, 144, 106, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	}

	if(frame>420){
	enter(c2d, 174, 90, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	}

	if(frame>420){
	enter(c2d, 166, 106, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	}


	// desenho das estrelas que aparecem em momentos diferentes na imagem
	if(frame>450){
		enter(c2d, 68, 17, 50, 50);
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}
	
	if(frame>500){
		enter(c2d, 216, 17, 50, 50);
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}

	if(frame>500){
		enter(c2d, 68, 169, 50, 50);
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}

	if(frame>550){
		enter(c2d, 365, 17, 50, 50 );
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}
	
	if(frame>550){
		enter(c2d, 68, 320, 50, 50);
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}
	
	if(frame>600){
		enter(c2d, 167, 219, 50, 50);
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}
	
	if(frame>600){
		enter(c2d, 266, 118, 50, 50 );
		estrela(c2d);
		leave(c2d, "white", c2d.strokeStyle);
	}


	// desenho do urso com varias translaçoes ate a posição correta e final
	if(frame>400){
		enter(c2d, z, 100, 100, 100);
		urso(c2d);
		leave(c2d, "black", c2d.strokeStyle);
		if(z>=150)
		{
			z-=2;
		}
	}
	
	enter(c2d, 59, 9, 478, 478);
	contorno2(c2d);

	c2d.restore();
}

/////////////////////////////////////////////////////////////////////////////////

scene = function(c2d, pos, size, rot) 
{
    this.c2d = c2d;
    this.pos = pos;
    this.size = size;

    this.animate = function() {

        c2d.fillStyle = "white";
        c2d.fillRect(0,0,512,512);
        
        enter(c2d, pos.x, pos.y, size.width, size.height);
        c2d.rotate(rot.alpha);
        mydraw(c2d);
        leave(c2d,"","");
        
        requestAnimationFrame(this.animate);
        
        TWEEN.update(); 
        frame++;
        console.log(frame);
    }
    return this;
}

// para a animação baseio me numa variavel chamada frame que vai sendo incrementada
// de modo a procedermos a introdução de novos desenhos consoante o frame desejado
var frame_goal=700;
var frame=0;
// variaveis x, y e z usadas para animações no desenho de objetos
var x=0;
var y=0;
var z=320;

function main()
{
	var c2d = document.getElementById("acanvas").getContext("2d");

	var pos = {x: 256, y: 256};
    var target_pos= { x: 10, y: 5};
    var pos_t = new TWEEN.Tween(pos).to(target_pos, 3000);
    pos_t.easing(TWEEN.Easing.Back.In);
    pos_t.start();

	var size = {width: 0, height: 0};
    var target_size = {width: 0.95, height: 0.95};
    size_t = new TWEEN.Tween(size).to(target_size, 6000);
    size_t.easing(TWEEN.Easing.Bounce.Out);
    size_t.start();

    var rot = {alpha: 0};
    var rot_target = {alpha: 2*Math.PI};
    var rot_tween = new TWEEN.Tween(rot)
        .to(rot_target, 3000)
        .repeat(0)
        .yoyo(false);
    rot_tween.easing(TWEEN.Easing.Bounce.InOut);
    rot_tween.start();

    var s = scene(c2d,pos,size, rot);
    
    s.animate();
}

