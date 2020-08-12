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


function enter(c2d, dx, dy, x, y)
{
	c2d.save();
	c2d.translate(dx,dy);
	c2d.scale(x, y);
}

function leave(c2d, fs, ss)
{
	c2d.restore();
    c2d.fillStyle = fs;
    c2d.strokeStyle = ss;
    c2d.fill();
    c2d.stroke();
}

function leave2(c2d)
{
	c2d.restore();
	//c2d.stroke();
}

function triangulo(c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.0, 0.0);
	c2d.lineTo(0.0, 0.70);
	c2d.arcTo(0.0, 0.75, 0.41, 1.0, 0.1);
	c2d.lineTo(0.82, 0.0);
	c2d.lineTo(0.0, 0.0);
	c2d.closePath();

	//c2d.fillStyle = "blue";
	//c2d.fill();

}

function triangulo2 (c2d)
{
	c2d.beginPath();
	c2d.moveTo(0.0, 0.0);
	c2d.lineTo(0.0, 0.8);
	c2d.lineTo(0.8, 0.0);
	c2d.lineTo(0.0, 0.0);
	c2d.closePath();

	//c2d.fillStyle = "blue";
	//c2d.fill();
}

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

function contorno2 (c2d)
{
	//c2d.save();

	c2d.beginPath();
	c2d.moveTo(0.82, 0.0);
	c2d.lineTo(0.82, 0.70);
	c2d.arcTo(0.82, 0.75, 0.41, 1.0, 0.1);
	c2d.lineTo(0.41, 1.06);
	c2d.lineTo(0.05, 0.78);
	c2d.lineTo(0.82, 0.0);
	c2d.closePath();


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

function risca (c2d)
{

	c2d.beginPath();
	c2d.fillRect(0, 0, 0.08, 1.0)
	c2d.closePath();
}


function arvore_topo (c2d)
{
	c2d.beginPath();
	c2d.ellipse(0.5, 0.49, 0.17, 0.13,0.0,0.0, 2*Math.PI);
	c2d.closePath();
}

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


function main()
{
	var c2d = document.getElementById("acanvas").getContext("2d");
    mydraw(c2d);
}

function mydraw(c2d) {
	c2d.strokeStyle = "transparent"; 

enter(c2d, 10, 0, 1.2, 1.2);



	enter(c2d, 50, 0, 500, 500);
		contorno(c2d);
	leave(c2d, "#f7d117", c2d.strokeStyle);
	//leave2(c2d);



	enter(c2d, 60, 10, 475, 475);
		contorno(c2d);
	leave(c2d, "white", c2d.strokeStyle);
	//leave2(c2d);

	//leave2(c2d);


	enter(c2d, 60, 10, 475, 475);
		triangulo(c2d);
	leave(c2d, "#171796", c2d.strokeStyle);
	//leave2(c2d);

	enter(c2d, 115, 65, 260, 260);
		triangulo2(c2d);
	leave(c2d, "white", c2d.strokeStyle);
	//leave2(c2d);

	enter(c2d, 52, 0, 200, 199);
		arvore_topo(c2d);
	leave(c2d, "#009959", c2d.strokeStyle);
	//leave2(c2d);

	enter(c2d, 131, 90, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	enter(c2d, 146, 84, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	enter(c2d, 156, 95, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	enter(c2d, 144, 106, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	enter(c2d, 174, 90, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);
	enter(c2d, 166, 106, 50, 50);
		maca(c2d);
	leave(c2d, "#d42e12", c2d.strokeStyle);


	enter(c2d, 52, 0, 200, 200);
		arvore_tronco(c2d);
	leave(c2d, "#703824", c2d.strokeStyle);

	enter(c2d, 150, 100, 100, 100);
		urso(c2d);
	leave(c2d, "black", c2d.strokeStyle);



	enter(c2d, 68, 17, 50, 50 );
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);

	enter(c2d, 216, 17, 50, 50 );
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);

	enter(c2d, 365, 17, 50, 50 );
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);

	enter(c2d, 68, 169, 50, 50);
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);

	enter(c2d, 68, 320, 50, 50);
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);

	enter(c2d, 167, 219, 50, 50);
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);

	enter(c2d, 266, 118, 50, 50 );
		estrela(c2d);
	leave(c2d, "white", c2d.strokeStyle);


	enter(c2d, 60, 10, 475, 475);
		contorno2(c2d);
	c2d.restore();

leave2(c2d);
}