$thicc=10;
$cubethicc=$thicc+2;
$plate=82;
$curverad=4;
$pad=65;

difference(){

// MainPlate
union(){

difference(){
cube([$plate,$plate,$thicc]);
    translate([0,0,-1]){
cube([$curverad,$curverad,$cubethicc]);
translate([$plate-$curverad,0,0])cube([$curverad,$curverad,$cubethicc]);
translate([$plate-$curverad,$plate-$curverad,0])cube([$curverad,$curverad,$cubethicc]);
translate([0,$plate-$curverad,0])cube([$curverad,$curverad,$cubethicc]);}}

translate([4,4,0]){
cylinder(r=4,h=$thicc,$fn=100);
translate([$plate-($curverad*2),0,0])cylinder(r=4,h=$thicc,$fn=100);
translate([$plate-($curverad*2),$plate-($curverad*2),0])cylinder(r=4,h=$thicc,$fn=100);
translate([0,$plate-($curverad*2),0])cylinder(r=4,h=$thicc,$fn=100);}
}
translate([($plate-$pad)/2,($plate-$pad)/2,7])cube([$pad,$pad,$thicc*2]);
translate([3+($plate-$pad)/2,3+($plate-$pad)/2,1]){
translate([$pad-6,0,0])cylinder(r=3,h=$thicc,$fn=100);
translate([$pad-6,$pad-6,0])cylinder(r=3,h=$thicc,$fn=100);
translate([0,$pad-6,0])cylinder(r=3,h=$thicc,$fn=100);

translate([$pad-6,$pad-6,7])cylinder(r=5,h=5,$fn=100);
    translate([0,$pad-6,7])cylinder(r=5,h=5,$fn=100);
    translate([$pad-6,0,7])cylinder(r=5,h=5,$fn=100);
    translate([0,0,7])cylinder(r=5,h=5,$fn=100);
}


translate([0,11,0])cube([16,10,5]);
translate([15,11.5,0])rotate([0,0,45])cube([82,5,3]);
translate([8,70,0])cube([64,2,3]);
translate([70,8,0])cube([2,64,3]);
#translate([60,16,0])cube([10,42,3]);
}
translate([($plate-$pad)/2+53.8,53.8+($plate-$pad)/2,7])cube([3,3,3]);