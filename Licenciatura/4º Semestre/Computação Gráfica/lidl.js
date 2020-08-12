function main(){
	var c2d = document.getElementById("acanvas").getContext("2d");
    
    c2d.beginPath();
    c2d.fillStyle = "blue";
    c2d.fillRect(10,10,100,100);
    c2d.fillStyle = "yellow";
    c2d.ellipse(60,60,45,45,0,0,2*Math.PI);
    c2d.fill();

}