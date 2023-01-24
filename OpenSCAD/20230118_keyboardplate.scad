difference(){
linear_extrude(2)import("/Users/nfnorange/Downloads/20230118_platedesign.svg");
linear_extrude(2)import("/Users/nfnorange/Downloads/20230118_platedesign-part2.svg");
//translate([-12,0,0])translate([150,0,0])cube([170,150,3]); 
translate([-12,0,0])cube([150,150,3]);translate([284.7,43,0])cube([4,2.9,3]);
}

