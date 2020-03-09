DeckSize=[40,67,67];
T=2;
PegD=5;
golden_ratio=0.618;

module internalHolder(){
	cube([DeckSize[0]+T,DeckSize[1]+T,T]);
	cube([DeckSize[0]+T,T,DeckSize[2]/2+T]);
	cube([T,DeckSize[1]+T,DeckSize[2]/2+T]);
	translate([0,DeckSize[1]+T,0])cube([DeckSize[0]+T,T,DeckSize[2]/2+T]);
	translate([DeckSize[0]+T,0,0])cube([T,DeckSize[1]+T*2,DeckSize[2]/2+T]);
};

module externalHolder(){
	cube([DeckSize[0]+T,DeckSize[1]+T,T]);
	translate([0,DeckSize[1]+T*2+(DeckSize[1]*(1-golden_ratio)+T*2),0])cube([DeckSize[0]+T,DeckSize[1]*golden_ratio+T,T]);
	translate([0,DeckSize[1]+T*2,0])cube([DeckSize[0]+T,DeckSize[1]*(1-golden_ratio)+T,T]);

	translate([0,-(DeckSize[1]+T*4),0])cube([DeckSize[0]+T,DeckSize[1]*golden_ratio+T,T]);
	translate([0,-(DeckSize[1]*(1-golden_ratio)+T*2),0])cube([DeckSize[0]+T,DeckSize[1]*(1-golden_ratio)+T,T]);

    // North
	translate([(DeckSize[0]+T*4)+(DeckSize[1]*(1-golden_ratio)),0,0])cube([DeckSize[1]*golden_ratio+T,DeckSize[2]+T,T]);
	translate([DeckSize[0]+T*2,0,0])cube([DeckSize[1]*(1-golden_ratio)+T,DeckSize[2]+T,T]);

    // South 
	translate([-((DeckSize[1]*golden_ratio+T*2)+(DeckSize[1]*(1-golden_ratio)+T*2)),0,0])cube([DeckSize[1]*golden_ratio+T,DeckSize[2]+T,T]);
	translate([-(DeckSize[1]*(1-golden_ratio)+T*2),0,0])cube([DeckSize[1]*(1-golden_ratio)+T,DeckSize[2]+T,T]);
};

module base(){
	cube([DeckSize[0]+T*5,DeckSize[1]+T*5,T]);
	cube([DeckSize[0]+T*5,T,DeckSize[2]*(1-golden_ratio)+T*5]);
	cube([T,DeckSize[1]+T*5,DeckSize[2]*(1-golden_ratio)+T*5]);
	translate([0,DeckSize[1]+T*5,0])cube([DeckSize[0]+T*5,T,DeckSize[2]*(1-golden_ratio)+T*5]);
	translate([DeckSize[0]+T*5,0,0])cube([T,DeckSize[1]+T*6,DeckSize[2]*(1-golden_ratio)+T*5]);
};
module lid(){
	cube([DeckSize[0]+T*5,DeckSize[1]+T*5,T]);
	cube([DeckSize[0]+T*5,T,DeckSize[2]*(golden_ratio)+T*5]);
	cube([T,DeckSize[1]+T*5,DeckSize[2]*(golden_ratio)+T*5]);
	translate([0,DeckSize[1]+T*5,0])cube([DeckSize[0]+T*5,T,DeckSize[2]*(golden_ratio)+T*5]);
	translate([DeckSize[0]+T*5,0,0])cube([T,DeckSize[1]+T*6,DeckSize[2]*(golden_ratio)+T*5]);
};
lid();
