DeckSize=[135,160,50];
T=2;
block=[82,87,67];
PegD=5;
golden_ratio=0.618;

module internalHolder(){
union(){
	translate([DeckSize[0]+T,DeckSize[1]+T,0])translate([0,0,DeckSize[2]/4+T/2])rotate([0,0,180])fillet(10,DeckSize[2]/2-T);
	translate([0,DeckSize[1]+T,0])translate([T,0,DeckSize[2]/4+T/2])rotate([0,0,270])fillet(10,DeckSize[2]/2-T);
	translate([DeckSize[0]+T,0,0])translate([0,T,DeckSize[2]/4+T/2])rotate([0,0,90])fillet(10,DeckSize[2]/2-T);
	translate([T,T,DeckSize[2]/4+T/2])fillet(10,DeckSize[2]/2-T);
	cube([DeckSize[0]+T,T,DeckSize[2]/2+T]);
	cube([T,DeckSize[1]+T,DeckSize[2]/2+T]);
	translate([0,DeckSize[1]+T,0])cube([DeckSize[0]+T,T,DeckSize[2]/2+T]);
	translate([DeckSize[0]+T,0,0])cube([T,DeckSize[1]+T*2,DeckSize[2]/2+T]);}
};

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}

module blockT(){
	difference(){
		cube([block[0],block[1],block[2]/2-1]);
		union(){
			translate([block[0],block[1],0])rotate([0,0,180])fillet(10,block[2]);
			translate([0,block[1],0])rotate([0,0,270])fillet(10,block[2]);
			translate([block[0],0,0])rotate([0,0,90])fillet(10,block[2]);
			fillet(10,block[2]);
		}
	}
}

module base(){
	difference(){
		cube([DeckSize[0],DeckSize[1],T]);
		translate([(DeckSize[0]/2)-block[0]/2,(DeckSize[1]/2)-block[1]/2,-T])blockT();
	}
}

// internalHolder();
// translate([T,T,0])base();

blockT();













































































































