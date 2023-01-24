l = 100;
w = 10;
h = 20;
p = 15;
t = 6;
fn = 15;

cube([w,l,t]);
translate([w,0,0])cube([l-w,w,t]);
translate([l-w,w,0])cube([w,l-(2*w),t]);
translate([w,l-w,0])cube([l-w,w,t]);
// pegs
translate([w/2,w/2,t])cylinder(5,1.5,1.5,$fn = fn);
translate([0,l-w,0])translate([w/2,w/2,t])cylinder(5,1.5,1.5,$fn = fn);
translate([l-w,0,0])translate([w/2,w/2,t])cylinder(5,1.5,1.5,$fn = fn);
translate([l-w,l-w,0])translate([w/2,w/2,t])cylinder(5,1.5,1.5,$fn = fn);


// cross
difference(){
    
union(){
    translate([(l-w)/2-1,w,0])cube([w+2,l-(2*w),t]);
    translate([w,(l-w)/2-1,0])cube([l-(2*w),w+2,t]);
}
    translate([(l/2),(l/2),-1])cylinder(t+2,4,4);
}