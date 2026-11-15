# TapTamer

**Looks like a normal tap. Works like a guardian. One knob on top does everything — and the water always ends closed.**

- **Turn** the knob — sets a **flow limit** (how much water may pass). Turning alone never runs water: a second valve below stays shut. *That is the safety.*
- **Press** the knob down — a quick rinse under 10 seconds that closes itself. Or just **hold** it down while you need water.
- **Pull** the knob up — a 3-minute wash that bleeds itself shut at zero.
- **Turn fully back to zero** — the tap is *locked*: even pressing gives nothing.

Two valves sit **in series** inside **one compact head cartridge** on top of the tap (the knob is only the handle). The column below is a **plain water tube — nothing goes inside it**. Your turn only sets a limit, a spring poppet decides if any water passes, and two oil dashpots (the same idea as a door closer) time the auto-close. No battery, no electronics, no dial, no clockwork — and **no combination of knob positions can leave the water running**.

![TapTamer, washing at a 7.6 L/min limit](screenshot.png)

## Try it in 3D

- **Live simulator:** once GitHub Pages is on, this repo serves it at
  `https://grimzeero78.github.io/Water/` (the page is `index.html`).
- **Offline:** just open `index.html` — it is a single self-contained file.

In the simulator: **drag the knob sideways** (or use the slider) to set the limit,
**click** it for the 8-second rinse, **drag down and hold** for water-while-held,
**drag up** for the 3-minute wash. Keys: `1` press · `2` pull · `←/→` turn ·
`L` lock · `0` stop. Ghost view (default) shows the limiter, poppet, both dashpots
and the latch working inside. Buttons: PRESS / PULL / LOCK / STOP.

Worst case at an 8 L/min limit: one 3-minute wash ≈ **24 L**. A normal tap left
running for an hour wastes about **480 L**.

## What's in this repo

| File | What it is |
|---|---|
| `index.html` | Interactive 3D simulator — press / pull / turn with the series-valve safety, ghost view, water-usage readouts |
| `prototype.html` | All 6 printable parts, exploded / assembled, viewable in any browser |
| `stl/` | 3D-printable STL parts: 1 wet body, 2 top knob, 3 flow limiter, 4 poppet valve, 5 short dashpot kit, 6 long dashpot kit + latch |
| `build-guide.pdf` | Workshop manual: tools, materials, build steps, fitting, calibration, troubleshooting, savings |
| `TapTamer.scad` | Parametric OpenSCAD source model (millimetres) |
| `guide-assets/` | Diagrams and renders used by the guide |

## How it works (pure mechanics)

Everything is packed into **one head cartridge** on top of a plain column — like the
inside of a clock, except there is no clockwork: just valves, springs and oil dashpots.

1. **Turn = limit only.** The knob spins a needle cartridge on its own seat at the base
   of the head. It can never let water through by itself — it only decides how wide the
   path *may* be. At zero the path is closed and the tap is locked.
2. **Press = short rinse.** Pushing the knob opens the poppet against its spring.
   A small dashpot meters the return, so the rinse shuts itself off in about 8
   seconds — even if you walk away. Holding the knob keeps water flowing only
   while you hold it.
3. **Pull = 3-minute wash.** A latch catches the poppet; a larger dashpot bleeds
   slowly for about 3 minutes, then the spring wins and the valve closes. No gears,
   no escapement, nothing to wind.
4. **Always ends closed.** The poppet is the only valve that can pass water, and it
   is spring-closed in every position. Turn, press, pull — every path ends shut.

## Fitting on your tap

TapTamer is a **complete replacement tap**, not a bolt-on. Because the whole mechanism
is one head cartridge and the column is a plain pipe, there is nothing to thread into
down the body: turn off the supply, undo the old tap's back-nut and lift it out, then
PTFE tape on the 1/2" tail, drop TapTamer through the same basin hole, tighten the
back-nut, connect the same flexible supply hose. **Servicing is one job too** — undo
three lid screws and the entire cartridge lifts out for the bench. Nothing sticks onto
a pipe, nothing wires in, nothing to charge.

## License

MIT — see [LICENSE](LICENSE).
