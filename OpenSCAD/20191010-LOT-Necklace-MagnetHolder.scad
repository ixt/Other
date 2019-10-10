magnet_thickness = 2;
magnet_diameter = 15;
lot_slug_width = 12;
lot_slug_depth = 1;
lot_slug_height = 45;
lot_string_thickness = 2;
case_wall_thickness = 0.5;
top_offset = (magnet_diameter - lot_slug_width) / 2;

// Base
cube([magnet_diameter + case_wall_thickness * 2, case_wall_thickness, magnet_thickness + case_wall_thickness * 2]);
translate([top_offset,0,magnet_thickness + case_wall_thickness * 2])
    cube([lot_slug_width + case_wall_thickness * 2, case_wall_thickness, lot_slug_depth + case_wall_thickness * 2]);
// Bottom wall
cube([magnet_diameter + case_wall_thickness * 2, lot_slug_height + case_wall_thickness * 2, case_wall_thickness]);
// Left wall
cube([case_wall_thickness, lot_slug_height + case_wall_thickness * 2, magnet_thickness + case_wall_thickness * 2]);
translate([top_offset, 0, magnet_thickness + case_wall_thickness * 2])
    cube([case_wall_thickness, lot_slug_height + case_wall_thickness * 2, lot_slug_depth + case_wall_thickness * 2]);
translate([0, 0, magnet_thickness + case_wall_thickness * 2])
    cube([top_offset + case_wall_thickness, lot_slug_height + case_wall_thickness * 2, case_wall_thickness]);
// Right wall 
translate([magnet_diameter + case_wall_thickness, 0, 0])
    cube([case_wall_thickness, lot_slug_height + case_wall_thickness * 2, magnet_thickness + case_wall_thickness * 2]);
translate([magnet_diameter + case_wall_thickness - top_offset, 0, magnet_thickness + case_wall_thickness * 2])
    cube([case_wall_thickness, lot_slug_height + case_wall_thickness * 2, lot_slug_depth + case_wall_thickness * 2]);
translate([magnet_diameter - top_offset + case_wall_thickness, 0, magnet_thickness + case_wall_thickness * 2])
    cube([top_offset + case_wall_thickness, lot_slug_height + case_wall_thickness * 2, case_wall_thickness]);
// Top wall
translate([top_offset,0,magnet_thickness + lot_slug_depth + case_wall_thickness * 4])
    cube([lot_slug_width + case_wall_thickness * 2, lot_slug_height + case_wall_thickness * 2, case_wall_thickness]);
// Top 
translate([top_offset,lot_slug_height + case_wall_thickness,magnet_thickness + case_wall_thickness * 2])
    cube([lot_slug_width / 2 - lot_string_thickness / 2, case_wall_thickness, lot_slug_depth + case_wall_thickness * 2]);
translate([top_offset + lot_slug_width/2  + lot_string_thickness/2 + case_wall_thickness *2 ,lot_slug_height + case_wall_thickness,magnet_thickness + case_wall_thickness * 2])
    cube([lot_slug_width / 2 - lot_string_thickness / 2, case_wall_thickness, lot_slug_depth + case_wall_thickness * 2]);
