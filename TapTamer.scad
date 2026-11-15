// ============================================================
//  TapTamer  -  Normal-looking self-closing tap  (V4)
//  A pillar tap whose whole mechanism lives inside the body.
//  ONE knob on top:  TURN = flow limit only (never opens water),
//  PRESS = ~8 s self-closing rinse,  PULL = ~3 min wash,
//  TURN to zero = lock.  Two valves in series + two oil dashpots.
//  No clockwork, no battery, no electronics, always ends closed.
//
//  Units: millimetres.  Print notes at bottom of file.
//  View: set mode to "assembled", "exploded" or "printbed".
//  Parts match stl/1..6 and prototype.html.
// ============================================================

/* ---------- PARAMETERS ---------- */
mode        = "assembled";   // assembled | exploded | printbed

// tap fitting (basin / sink mounting, like any pillar tap)
tail_thread = "G1/2";        // 1/2" BSP tail through the basin hole
tail_d      = 20;            // turned down from stock or brass insert
tail_len    = 45;            // reaches through basin hole + back-nut
backnut_d   = 30;

// body column
flange_d    = 64;
flange_t    = 8;
shank_d0    = 38;            // bottom of column
shank_d1    = 34;            // top of column
shank_len   = 130;
head_d0     = 32;
head_d1     = 43;
head_len    = 46;
bore_d      = 24;            // main waterway

// gooseneck spout
spout_od    = 19;
spout_id    = 12;

// knob
knob_d      = 42;
knob_h      = 30;
socket_sq   = 6.4;           // square drive from knob to limiter

// valve 1: flow limiter (your TURN)
limiter_seat_d  = 22;
limiter_needle0 = 22;        // cone, wide end
limiter_needle1 = 8;
limiter_stem_d  = 9;

// valve 2: poppet (press / pull)
poppet_d    = 28;            // disc, PTFE faced
poppet_stem = 6;
valve_lift  = 2.2;

// dashpots (oil + orifice => the timers)
dash_short_od = 18;          // ~8 s rinse return
dash_short_h  = 20;
dash_long_od  = 21;          // ~3 min wash release
dash_long_h   = 40;
orifice_short = 1.8;         // print, then trim with the needle in the guide
orifice_long  = 1.1;

$fn = 72;

/* ---------- MODULES ---------- */
module wet_body() {                     // 1 - tail + hollow column + head + spout
  difference() {
    union() {
      translate([0,0,-tail_len]) tail_boss();                        // G1/2 tail
      cylinder(d = flange_d, h = flange_t);                          // base flange
      translate([0,0,flange_t])
        cylinder(d1 = shank_d0, d2 = shank_d1, h = shank_len);       // column
      translate([0,0,flange_t+shank_len])
        cylinder(d1 = head_d0, d2 = head_d1, h = head_len);          // tapered head
      translate([0,0,flange_t+shank_len+head_len])
        cylinder(d = head_d1+2, h = 4);                              // head cap
      translate([0,0,0]) spout_shell();                              // gooseneck
    }
    translate([0,0,flange_t]) cylinder(d = bore_d, h = shank_len+head_len);
    translate([0,0,-tail_len-1]) cylinder(d = 13, h = tail_len+flange_t+2);  // inlet waterway
    translate([0,0,-tail_len])   cylinder(d = tail_d-1, h = 16);     // epoxy bed for brass G1/2 insert
    spout_channel();
  }
}

module tail_boss() {                    // the swap-in tail: through the basin hole,
  cylinder(d = tail_d+6, h = tail_len); // brass G1/2 insert epoxied in (or sealed
  translate([0,0,tail_len-2])           // printed boss), back-nut clamps from below
    cylinder(d = tail_d+6, h = 2);      // like any pillar tap
}

module spout_shell() {
  // arc: leaves the head, rises, tips over and points down
  pts = [[8,0,153],[24,0,168],[40,0,172],[54,0,165],[62,0,154],[66,0,146],[66,0,138]];
  for(i=[0:len(pts)-2])
    hull(){ translate(pts[i]) sphere(d=spout_od);
            translate(pts[i+1]) sphere(d=spout_od); }
  translate([66,0,132]) cylinder(d = 17, h = 8);                     // aerator boss
}

module spout_channel() {
  pts = [[0,0,160],[8,0,153],[24,0,168],[40,0,172],[54,0,165],[62,0,154],
         [66,0,146],[66,0,130]];
  for(i=[0:len(pts)-2])
    hull(){ translate(pts[i]) sphere(d=spout_id);
            translate(pts[i+1]) sphere(d=spout_id); }
}

module top_knob() {                     // 2 - dome + ribs + square socket
  difference() {
    union() {
      cylinder(d = knob_d,   h = 7);                                  // collar
      translate([0,0,7]) rotate_extrude()
        polygon([[0,0],[19,0],[20,5],[14,17],[10,20],[5,22],[0,23]]); // dome
      for(a=[0:36:359]) rotate([0,0,a])
        translate([19.2,0,12]) cube([3.2,4,11], center=true);         // grip ribs
    }
    translate([-socket_sq/2, -socket_sq/2, -1])
      cube([socket_sq, socket_sq, 18]);                              // square drive socket
    translate([0,0,-1]) cylinder(d = 10, h = 15);
  }
}

module flow_limiter() {                 // 3 - needle cartridge (turn = limit)
  union() {
    cylinder(d1 = limiter_needle0, d2 = limiter_needle1, h = 14);     // needle cone
    translate([0,0,14])  cylinder(d = limiter_stem_d, h = 16);
    translate([0,0,30])  cube([socket_sq, socket_sq, 7], center=false); // drive
  }
}

module poppet_valve() {                 // 4 - disc + stem + latch collar
  union() {
    cylinder(d = poppet_d, h = 4);                                    // disc
    translate([0,0,4])   cylinder(d = poppet_stem, h = 34);
    translate([0,0,12])  cylinder(d = 13,  h = 3);                    // latch collar
    translate([0,0,38])  cylinder(d = 10,  h = 3);                    // cap
  }
}

module dashpot_kit(od, h, orifice) {    // 5/6 - tube + piston + orifice cap
  union() {
    difference(){ cylinder(d = od, h = h); translate([0,0,-1]) cylinder(d = od-3, h = h+2); }
    translate([od+4,0,0]) union(){
      cylinder(d = od-3.6, h = 5);                                    // piston
      translate([0,0,5]) cylinder(d = 4, h = h+10);                   // rod
    }
    translate([2*od+8,0,0]) difference(){
      cylinder(d = od, h = 3);                                        // orifice cap
      translate([0,0,-1]) cylinder(d = orifice, h = 5);
    }
  }
}

module latch_lever() {                  // part of 6 - holds the pull open
  union() {
    cylinder(d = 10, h = 6);                                          // pivot boss
    translate([0,0,3]) cube([26,5,4], center=false);
    translate([24,-5,0]) cube([4,10,6]);
  }
}

/* ---------- LAYOUTS ---------- */
module assembled() {
  wet_body();
  translate([0,0,22])        flow_limiter();
  translate([0,0,95])        poppet_valve();
  translate([0,0,132])       dashpot_kit(dash_short_od, dash_short_h, orifice_short);
  translate([0,0,170])       dashpot_kit(dash_long_od,  dash_long_h,  orifice_long);
  translate([0,0,198])       top_knob();
  translate([-10.5,96,0]) rotate([0,0,90]) latch_lever();
}

module exploded() {
  wet_body();
  translate([-60,0,30])   flow_limiter();
  translate([60,0,85])    poppet_valve();
  translate([-70,0,135])  dashpot_kit(dash_short_od, dash_short_h, orifice_short);
  translate([75,0,165])   dashpot_kit(dash_long_od,  dash_long_h,  orifice_long);
  translate([0,0,245])    top_knob();
  translate([-55,120,0])  rotate([0,0,90]) latch_lever();
}

module printbed() {
  wet_body();
  translate([90,0,0])     top_knob();
  translate([150,0,0])    flow_limiter();
  translate([190,0,0])    poppet_valve();
  translate([230,0,0])    dashpot_kit(dash_short_od, dash_short_h, orifice_short);
  translate([300,0,0])    dashpot_kit(dash_long_od,  dash_long_h,  orifice_long);
  translate([370,0,0])    rotate([0,0,90]) latch_lever();
}

if(mode=="assembled") assembled();
else if(mode=="exploded") exploded();
else printbed();

/* ---------- PRINT NOTES ----------
 1  wet_body        PETG, 0.2 mm layers, 4 walls, supports for the spout arc
                    and the tail; epoxy a brass G1/2 tail insert into the
                    tail boss (epoxy bed is printed for it).
 2  top_knob        PLA or PETG, no supports; socket reams to a crisp square.
 3  flow_limiter    PETG; the cone seals on its seat with a light lapping of
                    silicone grease. Square drive fits the knob socket.
 4  poppet_valve    PETG; face the disc with a PTFE washer (or print a soft
                    bumper) so it seals on the seat without grinding.
 5  short dashpot   PETG, Vase-mode-able tube; charge with silicone oil 350 cSt,
                    orifice ~1.8 mm gives a ~8 s return - trim wider = faster.
 6  long dashpot    same, orifice ~1.1 mm gives ~3 min; adjust in testing.
                    The latch lever prints in the same file, on the same bed.
 Bought, not printed: closing spring 12x1.2x25 (~30 N), silicone oil 350 cSt,
 brass G1/2 tail insert + back-nut + flexible hose (any plumbing shop, the
 "tap fitting kit"), PTFE tape, O-rings. Fitting = swap the old tap for this
 one: same basin hole, same 1/2" tail, same supply hose.
 -------------------------------- */
