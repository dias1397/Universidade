function main() {
    var c2d = document.getElementById("acanvas").getContext("2d");
    
    c2d.beginPath();
    c2d.moveTo(0,0);
    c2d.arcTo(0,64,64,64,16);
    c2d.lineTo(64,64);
    c2d.stroke();	
}