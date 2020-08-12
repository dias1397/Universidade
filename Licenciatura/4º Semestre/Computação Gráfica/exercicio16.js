function nagon(n)
{
	var points = new Array(n);
	var angle = 2 * Math.PI / n;
	concole.log(angle);
	var alpha = 0.0;

	for (var i = 0; i < n; i++)
	{
		var x = Math.cos(alpha);
		var y = Math.sin(alpha);
		points[i] = {
			x: x,
			y: y
		};

	}
}


function main() 
{
    var c2d = document.getElementById("acanvas").getContext("2d");
    
    nagon(67);
   
}