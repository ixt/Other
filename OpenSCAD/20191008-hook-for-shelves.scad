l = 160;
w = 10;
h = 20;
p = 15;

cube([w,2,h]);
cube([w,l,3]);
translate([0,l,0])cube([w,2,h]);
translate([0,l-12,h])cube([w,14,2]);
translate([w/2-2.5,-p,h/2-2])cube([w/2,p,2]);
translate([w/2-2.5,-p,0])cube([w/2,2,h/2]);
