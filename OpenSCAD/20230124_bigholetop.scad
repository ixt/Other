difference(){translate([78.9,3.8,2])import("/Users/nfnorange/Downloads/Raspberry_Pico_Macro_Pad_4816077/files/pico_macro_pad_top_v2.stl");
$vart=3.8;
    $raid=1.95;
#translate([$vart ,$vart ,0])cylinder(3,$raid,$raid, $fn=100);
  #translate([$vart+57.55 ,$vart ,0])cylinder(3,$raid,$raid, $fn=100);  
    #translate([$vart+57.55 ,$vart+57.55 ,0])cylinder(3,$raid,$raid, $fn=100);
    #translate([$vart ,$vart+57.55 ,0])cylinder(3,$raid,$raid, $fn=100);
    }
