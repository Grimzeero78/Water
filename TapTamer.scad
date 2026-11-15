// ============================================================
//  TapTamer  -  Mechanical Auto-Off Tap Timer  (V3)
//  Screws onto a kitchen / bathroom tap spout in place of the
//  aerator. Twist the dial -> water on + clockwork counting.
//  At zero the cam trips the latch, the closing spring snaps
//  the poppet shut. No battery, no electronics, never stays on.
//
//  Units: millimetres.  Print notes at bottom of file.
//  View: set mode to "assembled", "exploded" or "printbed"
// ============================================================

/* ---------- PARAMETERS ---------- */
mode          = "assembled";   // assembled | exploded | printbed

// tap connection (measure your spout thread first!)
spout_thread  = "M22x1";       // M22x1 (most EU) | M24x1 | 55/64-27 (US male)
thread_d      = 22;            // nominal thread diameter
thread_pitch  = 1;
thread_len    = 8;

// valve
orifice_d     = 8;             // valve seat orifice
poppet_d      = 17;            // poppet disc (PTFE faced)
lift          = 2.2;           // valve opening lift
body_od       = 34;            // wet-body outer diameter
body_len      = 44;

// head (timer drum, stays dry)
head_od       = 60;
head_len      = 40;
movement_d    = 56;            // salvaged egg-timer / oven-timer movement
movement_t    = 18;

// dial
dial_d        = 50;
dial_t        = 12;
scale_max_min = 10;            // 0..10 minutes across 60 degrees

$fn = 72;

/* ---------- HELPERS ---------- */
// simple printable v-thread (visual approximation, test-fit first)
module v_thread(d, pitch, turns) {
    h = pitch * turns;
    linear_extrude(height = h, twist = 360 * turns, slices = turns * 24)
        translate([d/2 - 0.4, 0]) circle(r = pitch * 0.42, $fn = 6);
}

module knurl(r, h, teeth = 24) {
    for (i = [0 : teeth - 1])
        rotate([0, 0, i * 360 / teeth])
            translate([r, 0, h/2]) cylinder(d = 3.2, h = h, center = true);
}

/* ---------- WET BODY (brass, or print in PETG for prototyping) ---------- */
module wet_body() {
    difference() {
        union() {
            // main barrel
            cylinder(d = body_od, h = body_len);
            // head mounting flange (top)
            translate([0, 0, body_len])
                cylinder(d = head_od - 6, h = 4);
        }
        // through bore (water path)
        translate([0, 0, -1]) cylinder(d = orifice_d + 9, h = body_len + 6);
        // seat orifice (restriction where poppet closes)
        translate([0, 0, 12]) cylinder(d1 = orifice_d, d2 = orifice_d, h = 3);
        // inlet socket: female thread up (screws onto spout)
        translate([0, 0, body_len - thread_len + 4])
            cylinder(d = thread_d + 1.2, h = thread_len + 6);
        translate([0, 0, body_len - thread_len + 2]) 
            v_thread(d = thread_d, pitch = thread_pitch, turns = thread_len / thread_pitch);
        // outlet: male thread down for aerator / adapter
        translate([0, 0, -0.1]) v_thread(d = 24, pitch = 1, turns = 5);
    }
}

/* ---------- POPPET VALVE (PTFE disc + steel stem) ---------- */
module poppet() {
    union() {
        cylinder(d = poppet_d, h = 4);                       // disc
        translate([0, 0, 4]) cylinder(d = 6, h = 14);        // stem
        translate([0, 0, 16]) cylinder(d = 19, h = 2.5);     // latch flange
    }
}

/* ---------- CLOSING SPRING (buy: 12 x 1.2 x 25 mm, ~30 N) ---------- */
module closing_spring() {
    coils = 7; r = 6; h = 25;
    for (i = [0 : coils * 8])
        rotate([0, 0, i * 360 / (coils * 8)])
            translate([r, 0, i * h / (coils * 8)]) sphere(d = 1.2, $fn = 8);
}

/* ---------- LATCH LEVER (print in PETG, 3 mm thick) ---------- */
module latch() {
    linear_extrude(height = 3) union() {
        hull() { translate([0, 0]) circle(d = 7); translate([16, 0]) circle(d = 5); }
        // hook under the flange
        translate([17.5, -3]) square([4, 6]);
        // tail the cam push-rod presses on
        translate([1.5, 2])  square([4, 7]);
    }
}

/* ---------- HEAD DRUM (houses the clockwork, stays dry) ---------- */
module head() {
    difference() {
        union() {
            cylinder(d = head_od, h = head_len);                 // drum
            translate([0, 0, -6]) cylinder(d = head_od - 10, h = 6); // gland boss
        }
        // cavity for movement
        translate([0, 0, 4]) cylinder(d = movement_d, h = head_len);
        // front opening for the dial shaft
        translate([0, 0, -1]) cylinder(d = 10, h = 6);
        // sealed hole for cam push-rod (bottom)
        translate([0, 0, -7]) cylinder(d = 5, h = 8);
    }
}

/* ---------- DIAL KNOB (twist to 3 or 7, scale 0-10 min / 60 deg) ---------- */
module dial_knob() {
    difference() {
        union() {
            cylinder(d = dial_d, h = dial_t);
            translate([0, 0, dial_t/2]) knurl(r = dial_d/2 - 0.6, h = dial_t);
        }
        translate([0, 0, -1]) cylinder(d = 8, h = dial_t + 2);  // shaft fitting (square-file to fit)
        // engraved index notch
        rotate([0, 0, 0]) translate([dial_d/2 - 4, 0, dial_t - 1.2]) cube([6, 2, 2], center = true);
    }
}

/* ---------- CAM DRUM (on movement output shaft) ---------- */
module cam_drum() {
    union() {
        cylinder(d = 24, h = 14);
        translate([0, -14.5, 7]) cube([8, 6, 10], center = true);   // lobe
        translate([0, -16, 7]) rotate([90, 0, 0]) cylinder(d = 4, h = 6, center = true); // push-rod pin
    }
}

/* ---------- ASSEMBLY ---------- */
ex = mode == "exploded" ? 1 : 0;

module assembled() {
    color("Goldenrod")        wet_body();
    color("Silver")           translate([0, 0, 12 + lift + 14*ex]) poppet();
    color("Gray")             translate([0, 0, 18]) closing_spring();
    color("Crimson")          translate([-20, 2, 30]) latch();
    color("LightSlateGray")   translate([0, 0, body_len + 4 + 18*ex]) head();
    color("Ivory")            translate([0, 0, body_len + 10 - 6])  cam_drum();
    color("DimGray")          translate([0, 0, body_len + 4 + head_len + 10*ex]) rotate([180, 0, 0]) dial_knob();
}

module printbed() {
    wet_body();
    translate([45, 0, 0])   rotate([180, 0, 0]) poppet();
    translate([45, 40, 0])  rotate([90, 0, 0]) latch();
    translate([-45, 0, 0])  rotate([180, 0, 0]) head();
    translate([-45, 70, 0]) dial_knob();
    translate([0, 75, 0])   rotate([90, 0, 0]) cam_drum();
}

if (mode == "printbed") printbed();
else assembled();

/* ---------- PRINT & BUILD NOTES ----------
 *  PRINT (PETG, 0.2 mm layers, 4 walls):
 *    - wet_body, poppet, latch, cam_drum  -> PETG (hot water zone)
 *    - head, dial_knob                    -> PLA or PETG
 *  BUY, don't print:
 *    - closing spring 12 x 1.2 x 25 mm (~30 N)
 *    - 60-minute mechanical timer movement (salvage an egg timer
 *      or oven timer, or buy a replacement movement)
 *    - PTFE sheet 0.5 mm for the poppet face, O-rings 22x2 & 30x3
 *    - silicone grease (O-rings + cam gland)
 *  THREADS: the v_thread module is a visual approximation.
 *    For a watertight fit prefer buying a brass M22x1/M24x1
 *    aerator adapter and gluing/epoxying it into the body.
 *  SCALE: dial reads 0-10 minutes over 60 degrees; hard stops
 *    at 0 and 10 - the valve can never latch open.
 *  ------------------------------------------------------------
 */
