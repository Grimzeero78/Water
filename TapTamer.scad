// ============================================================
//  TapTamer  -  Normal-looking self-closing tap  (V6)
//  A pillar tap with a PLAIN column: the whole mechanism lives
//  in ONE compact head cartridge on top. Nothing down the pipe.
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

// plain column - just a water tube, nothing inside it
flange_d    = 64;
flange_t    = 8;
shank_d0    = 34;            // bottom of column
shank_d1    = 32;            // top of column
shank_len   = 132;           // z 8 .. 140  EMPTY
col_bore    = 16;

// mechanism head - ONE cartridge, z 140 .. 204
head_d      = 54;            // drum OD
head_base   = 8;             // solid base: limiter seat floor
head_h      = 64;
head_cap_h  = 4;             // service lid, z 200 .. 204
chamber_d   = 44;            // z 148 .. 200

// gooseneck spout (leaves the head high, under the lid)
spout_od    = 19;
spout_id    = 12;

// knob
knob_d      = 42;
knob_h      = 30;
socket_sq   = 6.4;           // square drive from knob down to the limiter

// valve 1: flow limiter (your TURN) - sits on the head base, z 148 ..
limiter_seat_d  = 22;
limiter_needle0 = 22;        // cone, wide end
limiter_needle1 = 8;
limiter_stem_d  = 9;

// valve 2: poppet (press / pull) - upper head, disc on the lid seat ring
poppet_d    = 28;            // disc, PTFE faced
poppet_stem = 10;            // tube stem around the drive shaft
valve_lift  = 5.5;

// dashpots (oil + orifice => the timers), flanking the stem in the head
dash_short_od = 18;          // ~8 s rinse return
dash_short_h  = 20;
dash_long_od  = 21;          // ~3 min wash release
dash_long_h   = 36;
orifice_short = 1.8;         // print, then trim with the needle in the guide
orifice_long  = 1.1;

$fn = 72;

/* ---------- MODULES ---------- */
module wet_body() {                     // 1 - tail + flange + PLAIN column + head drum + spout
  difference() {
    union() {
      translate([0,0,-tail_len]) tail_boss();                        // G1/2 tail
      cylinder(d = flange_d, h = flange_t);                          // base flange
      translate([0,0,flange_t])
        cylinder(d1 = shank_d0, d2 = shank_d1, h = shank_len);       // PLAIN column
      translate([0,0,flange_t+shank_len])
        cylinder(d = head_d, h = head_h);                            // head drum
      translate([0,0,0]) spout_shell();                              // gooseneck
    }
    translate([0,0,flange_t])
      cylinder(d = col_bore, h = shank_len+head_base);               // plain column bore
    translate([0,0,flange_t+shank_len+head_base])
      cylinder(d = chamber_d, h = head_h-head_base-head_cap_h);      // mechanism chamber
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

module head_lid() {                     // 1b - service lid: cap + gland + poppet seat ring
  difference() {
    union() {
      cylinder(d = head_d+3, h = head_cap_h);                      // cap, z 0..4
      translate([0,0,-4]) difference() {                           // seat ring, z -4..0
        cylinder(d = 34, h = 4);                                   // hangs under the cap
        translate([0,0,-1]) cylinder(d = 30, h = 6);               // water bore, disc lifts through
      }
      translate([0,0,-4]) difference() {                           // stem guide boss, z -4..0
        cylinder(d = 14, h = 4);
        translate([0,0,-1]) cylinder(d = 11, h = 6);               // gland for the tube stem
      }
    }
    translate([0,0,-5]) cylinder(d = 11, h = head_cap_h+6);        // stem passes through
    for(a=[90:120:359]) rotate([0,0,a])
      translate([head_d/2-1,0,-1]) cylinder(d = 3.2, h = 6);       // 3 screws to the drum
  }
}

module spout_shell() {
  // arc: leaves the head high (beside the seat ring), tips over, points down
  pts = [[24,0,197],[34,0,208],[48,0,210],[60,0,200],[66,0,178],[66.5,0,160],[66,0,150]];
  for(i=[0:len(pts)-2])
    hull(){ translate(pts[i]) sphere(d=spout_od);
            translate(pts[i+1]) sphere(d=spout_od); }
  translate([66,0,140]) cylinder(d = 17, h = 8);                     // aerator boss
}

module spout_channel() {
  pts = [[0,0,197],[24,0,197],[34,0,208],[48,0,210],[60,0,200],[66,0,178],[66.5,0,160],[66,0,140]];
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
    translate([0,0,-1]) cylinder(d = 15, h = 16);                    // clears the poppet flange
  }
}

module flow_limiter() {                 // 3 - seat + needle cone + drive rod (turn = limit)
  union() {
    difference(){                                                     // seat on the chamber floor
      cylinder(d = limiter_seat_d, h = 4);
      translate([0,0,-1]) cylinder(d = 10, h = 6);
    }
    translate([0,0,4]) cylinder(d1 = limiter_needle0, d2 = limiter_needle1, h = 14);
    translate([0,0,18]) cylinder(d = limiter_stem_d, h = 6);
    translate([-socket_sq/2, -socket_sq/2, 24])
      cube([socket_sq, socket_sq, 36]);                              // drive rod up to the knob
  }
}

module poppet_valve() {                 // 4 - disc + tube stem + flange
  difference() {
    union() {
      cylinder(d = poppet_d, h = 4);                                 // disc
      translate([0,0,4])  difference() {                             // tube stem
        cylinder(d = poppet_stem, h = 10);
        translate([0,0,-1]) cylinder(d = 7, h = 12);
      }
      translate([0,0,14]) cylinder(d = 14, h = 3);                   // flange: knob presses,
    }                                                                // latch catches under it
    translate([0,0,-1]) cylinder(d = 15, h = 8);                     // disc bore (guide boss)
    translate([0,0,3])  cylinder(d = 7, h = 15);                     // drive shaft bore
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
    cylinder(d = 10, h = 6);                                          // pivot boss (drum wall)
    translate([0,0,3]) cube([26,5,4], center=false);
    translate([24,-5,0]) cube([4,10,6]);
  }
}

module rocker_lever() {                 // part of 6 - converts press-down to lift
  union() {
    cylinder(d = 8, h = 5);                                           // pivot boss on the lid
    translate([0,0,4]) cube([16,5,3], center=false);                  // short arm to the knob
    translate([-14,-2.5,4]) cube([16,5,3], center=false);             // long arm to the flange
  }
}

/* ---------- LAYOUTS ---------- */
module assembled() {
  wet_body();
  translate([0,0,148])       flow_limiter();
  translate([0,0,192])       poppet_valve();
  translate([-13,0,172])     dashpot_kit(dash_short_od, dash_short_h, orifice_short);
  translate([13,0,156])      dashpot_kit(dash_long_od,  dash_long_h,  orifice_long);
  translate([-22,0,196])     rotate([0,0,90]) latch_lever();
  translate([0,0,200])       head_lid();
  translate([0,0,204])       top_knob();
}

module exploded() {
  wet_body();
  translate([-70,0,150])   flow_limiter();
  translate([75,0,192])    poppet_valve();
  translate([-80,0,178])   dashpot_kit(dash_short_od, dash_short_h, orifice_short);
  translate([85,0,160])    dashpot_kit(dash_long_od,  dash_long_h,  orifice_long);
  translate([-55,110,0])   rotate([0,0,90]) latch_lever();
  translate([0,0,240])     head_lid();
  translate([0,0,275])     top_knob();
}

module printbed() {
  wet_body();
  translate([85,0,204])    head_lid();     // lid prints beside the body
  translate([90,0,0])      top_knob();
  translate([150,0,0])     flow_limiter();
  translate([190,0,0])     poppet_valve();
  translate([230,0,0])     dashpot_kit(dash_short_od, dash_short_h, orifice_short);
  translate([300,0,0])     dashpot_kit(dash_long_od,  dash_long_h,  orifice_long);
  translate([370,0,0])     rotate([0,0,90]) latch_lever();
  translate([420,0,0])     rocker_lever();
}

if(mode=="assembled") assembled();
else if(mode=="exploded") exploded();
else printbed();

/* ---------- PRINT NOTES ----------
 1  wet_body        PETG, 0.2 mm layers, 4 walls, supports for the spout arc
                    and the tail; epoxy a brass G1/2 tail insert into the
                    tail boss (epoxy bed is printed for it). The column is
                    PLAIN - nothing goes inside it.
 1b head_lid        Prints beside the body in the same file. Carries the poppet
                    seat ring, the stem gland and the rocker pivot; 3 screws
                    close the head - undo them and the cartridge is on the bench.
 2  top_knob        PLA or PETG, no supports; socket reams to a crisp square;
                    the 15 mm centre bore clears the poppet flange.
 3  flow_limiter    PETG; seat ring + needle cone + drive rod in one piece.
                    The cone seals on its seat with a light lapping of
                    silicone grease. The square rod runs up through the poppet
                    stem into the knob socket - turn = limit, never open.
 4  poppet_valve    PETG; face the disc with a PTFE washer so it seals on the
                    lid's seat ring. The disc bore rides on the lid's guide boss.
 5  short dashpot   PETG, Vase-mode-able tube; charge with silicone oil 350 cSt,
                    orifice ~1.8 mm gives a ~8 s return - trim wider = faster.
 6  long dashpot    same, orifice ~1.1 mm gives ~3 min; adjust in testing.
                    The latch lever AND the rocker lever print in this file.
 Bought, not printed: closing spring 12x1.2x45 (~30 N, stands on the limiter
 stem, pushes the disc up against the seat ring), silicone oil 350 cSt,
 brass G1/2 tail insert + back-nut + flexible hose (any plumbing shop, the
 "tap fitting kit"), PTFE tape, O-rings, 3x M3 screws for the lid.
 Fitting = swap the old tap for this one: same basin hole, same 1/2" tail,
 same supply hose. Servicing = 3 screws, one lid, the cartridge lifts out.
 -------------------------------- */
