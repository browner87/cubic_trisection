x = 100; // Not really relevant. Just the output size. A larger object scaled down later will have nicer edges

// The distance between opposite corners of a side of the cube
pythag    = sqrt(pow(x,2)+pow(x,2));
// The second angle to tilt things by to make them hit the cube's corners
pythangle = atan(x/pythag);
// The distance between opposite corners of the cube
corners   = sqrt(pow(pythag,2)+pow(x,2));
// In theory all parts are identical (for a cube), but this lets you pick which
// of the 3 parts you're generating
slice     = 1;

// Intersection "subtracts" the helix from the cube and leaves only the overlap
intersection(){
	// Rotate the spirals so the cube (and thus output part) sit flat for printing
	rotate([pythangle,45,0]){
		// Move the start (/end) of the spiral to a corner of the cube
		translate([0,0,-corners/2]){
			// Turn the pie section into a helix
			linear_extrude(height = corners, 
		                  center = false, 
		                  convexity = 10, 
		                  twist = 360, 
		                  $fn = 300)
				pie_slice(x, 120*(slice-1), 120*slice);
		}
	}
	cube([x,x,x], center=true);
}

// Pie slice code by nophead
// http://forum.openscad.org/Creating-pie-pizza-slice-shape-need-a-dynamic-length-array-tp3148p3155.html
module pie_slice(r, start_angle, end_angle) {
	R = r * sqrt(2) + 1;
	a0 = (4 * start_angle + 0 * end_angle) / 4;
	a1 = (3 * start_angle + 1 * end_angle) / 4;
	a2 = (2 * start_angle + 2 * end_angle) / 4;
	a3 = (1 * start_angle + 3 * end_angle) / 4;
	a4 = (0 * start_angle + 4 * end_angle) / 4;
   if(end_angle > start_angle)
		intersection() {
      circle(r);
      polygon([
			[0,0],
			[R * cos(a0), R * sin(a0)],
			[R * cos(a1), R * sin(a1)],
			[R * cos(a2), R * sin(a2)],
			[R * cos(a3), R * sin(a3)],
			[R * cos(a4), R * sin(a4)],
			[0,0]
		]);
	}
}