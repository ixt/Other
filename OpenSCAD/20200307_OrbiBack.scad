l = 60;
ll = 30;
w = 26;
t = 3;
p = 15;
pp = 10;

// translate([0,10,-20])cube([30,30,8]);
module clips(){
difference(){
    translate([0,0,-12])cube([30,p,3]);
    translate([2.5,12.5,-20])cylinder(h=15, r=1.5);
    translate([27.5,12.5,-20])cylinder(h=15, r=1.5);
}
difference(){
    translate([0,0,-12])cube([t,p,12]);
    translate([2.5,12.5,-20])cylinder(h=15, r=1.5);
}

difference(){
    translate([0,p+20,-12])cube([30,p,3]);
    translate([2.5,37.5,-20])cylinder(h=15, r=1.5);
    translate([27.5,37.5,-20])cylinder(h=15, r=1.5);
};
difference(){
    translate([0,p+20,-12])cube([t,p,12]);
    translate([2.5,37.5,-20])cylinder(h=15, r=1.5);
};
}
clips();
rotate(45,[90,0,0])cube([w,t,pp]);
cube([w,l,t]);
translate([0,l,0])cube([w,ll,t]);
