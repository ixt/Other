l = 60;
ll = 33;
w = 26;
t = 3;
p = 15;
pp = 10;
$fn = 20;

// translate([0,10,-20])cube([30,30,8]);
module clips(){
difference(){
    translate([0,0,-12])cube([41,p,3]);
    translate([2.5,11.5,-20])cylinder(h=15, r=2);
    translate([37.5,11.5,-20])cylinder(h=15, r=2);
}
difference(){
    translate([0,0,-12])cube([t,p,12]);
    translate([2.5,11.5,-20])cylinder(h=15, r=2);
}

translate([0,9,0])difference(){
    translate([0,p+19,-12])cube([41,p-3,3]);
    translate([2.5,37.5,-20])cylinder(h=15, r=2);
    translate([37.5,37.5,-20])cylinder(h=15, r=2);
    translate([37.5,42.5,-20])cylinder(h=15, r=2);
    translate([2.5,42.5,-20])cylinder(h=15, r=2);
};
translate([0,9,0])difference(){
    translate([0,p+19,-12])cube([t,p-3,12]);
    translate([2.5,37.5,-20])cylinder(h=15, r=2);
    translate([2.5,42.5,-20])cylinder(h=15, r=2);
};
translate([0,14,0])difference(){
    translate([0,p+54,-12])cube([41,p-5,3]);
    translate([37.5,72.5,-20])cylinder(h=15, r=2);
    translate([2.5,72.5,-20])cylinder(h=15, r=2);
};
translate([0,14,0])difference(){
    translate([0,p+54,-12])cube([t,p-5,12]);
    translate([2.5,72.5,-20])cylinder(h=15, r=2);
};
}
clips();
rotate(45,[90,0,0])cube([w,t,pp]);
cube([w,l,t]);
translate([0,l,0])cube([w,ll,t]);
// translate([0,9,-22])cube([40,40,10]);
// translate([0,49,-22])cube([40,40,10]);

