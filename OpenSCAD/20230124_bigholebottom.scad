difference(){translate([-146.2,3.8,1])import("/Users/nfnorange/Downloads/VOID9_Macropad_4222157/files/VOID9_-_Bottom_-_Flat.stl");
$vart=3.8;
    $raid=1.95;
translate([$vart ,$vart ,0])cylinder(20,$raid,$raid, $fn=100);
  translate([$vart+57.55 ,$vart ,0])cylinder(20,$raid,$raid, $fn=100);  
    translate([$vart+57.55 ,$vart+57.55 ,0])cylinder(20,$raid,$raid, $fn=100);
    translate([$vart ,$vart+57.55 ,0])cylinder(20
,$raid,$raid, $fn=100);
    translate([15.5,22.5,1.1])cube([35,30,10]);
    translate([32.5,32.5,14])cube([58,58,11], center=true);
    translate([45.5,0,5])cube([23,15,8], center=true);
    translate([8.8,$vart+50,0])cube([3,3,3]);
    translate([$vart ,$vart ,5])cylinder(3.5,5,5,$fn=6);
    translate([$vart+57.55 ,$vart+57.55,5])cylinder(3.5,5,5,$fn=6);
    translate([$vart ,$vart+57.55,5])cylinder(3.5,5,5,$fn=6);
    }
translate([32.5,65-1.8,5])cube([20,4,8],center=true);

translate([13,0,0]){
translate([20,0,1])cube([1,52,1]);
translate([44,0,1])cube([1,52,1]);
translate([20,52,1])cube([25,1,1]);
difference(){
translate([32.5,0.5,5])cube([23,1,8], center=true);
translate([29.5,-0.5,2.8])cube([6,20,3.5]);
translate([29.5,-0.5,4.55])rotate([90,0,180])cylinder(20,1.75,1.75, $fn=100);
translate([35.5,-0.5,4.55])rotate([90,0,180])cylinder(20,1.75,1.75, $fn=100);}}