# TapTamer

**Looks like a normal tap. Works like a guardian. One knob on top does everything — and the water always ends closed.**

- **Press** the knob down — a quick rinse under 10 seconds that closes itself (a dashpot bleeds it shut).
- **Pull** the knob up — a 3-minute wash; a hidden escapement counts it down and shuts off at zero.
- **Turn** the knob — opens like any tap and sets how much water passes. Turn back to close.

No battery, no electronics, no dial, no display — and no way to leave the water running.

![TapTamer device on a tap spout](guide-assets/cover_device.png)

## Try it in 3D

- **Live simulator:** once GitHub Pages is on, this repo serves it at
  `https://grimzeero78.github.io/Water/` (the page is `index.html`).
- **Offline:** just open `index.html` — it is a single self-contained file.

In the simulator: **press** the top knob (or the PRESS button) for an 8-second
self-closing rinse, **pull** it up for the 3-minute wash, and **turn** it — drag the
knob sideways or use the flow slider — to open it like a normal tap. Ghost view
shows the dashpot, latch, escapement, cam drum and flow spindle working inside.
Press any running tap again (or STOP) to close it early.

## What's in this repo

| File | What it is |
|---|---|
| `index.html` | Interactive 3D simulator — timed runs, ghost-view mechanism, water usage readouts |
| `prototype.html` | All 6 printable parts, exploded / assembled, viewable in any browser |
| `stl/` | 3D-printable STL parts: 1 wet body, 2 poppet valve, 3 latch lever, 4 head drum, 5 dial knob, 6 cam drum |
| `build-guide.pdf` | Workshop manual: tools, materials, 9 build steps, tap fitting, calibration, troubleshooting, savings |
| `TapTamer.scad` | Parametric OpenSCAD source model (millimetres) |
| `guide-assets/` | Diagrams and renders used by the guide |

> **Note:** the printable-parts set (`stl/`, `TapTamer.scad`, `build-guide.pdf`)
> still documents the earlier dial-top variant. The press / pull / turn redesign
> ships first in the simulator; the parts and guide will be updated to match.

## How it works (pure mechanics)

1. **Press** — the knob dips and opens the poppet directly; when you let go, a small
   dashpot bleeds the pressure away and the closing spring shuts the valve within seconds.
2. **Pull** — a latch holds the valve open while a hidden escapement ticks off 3 minutes;
   a cam drum rides down as it unwinds and trips the latch at zero.
3. **Turn** — a flow spindle lifts off its seat like any screw-down tap; you decide how
   much water passes. Turn back to close.
4. **Always ends closed** — there is no stay-on position: even fully turned open, a
   mechanical safety trips the valve shut at 10 minutes.

## Fitting on your tap

Installs like any normal basin tap: PTFE tape on the 1/2" tail thread, drop it
through the basin or sink hole, tighten the back-nut, and connect the flexible
supply hose. The whole mechanism lives inside the column — nothing to wire,
nothing to charge.

## License

MIT — see [LICENSE](LICENSE).
