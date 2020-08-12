function main() {
    var c2d = document.getElementById("acanvas").getContext("2d");
    
    c2d.beginPath();
    c2d.moveTo(50,0);
    c2d.arcTo(0, 50, 50, 100, 70);
    c2d.arcTo(0, 50, 50, 0, 45);
    c2d.lineTo(50,0);
    c2d.fillStyle = "blue";
    c2d.fill();


    c2d.stroke();
    
}