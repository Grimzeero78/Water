# 04 - Facts and Sources: every number traced to the real world

TapTamer's simulator and documents are not guesswork. Each quantity below is
pinned to a published standard, regulator figure or industry sizing table.
Where something is a design *target* rather than a published fact, it is
labelled honestly as one.

## Flow rates (what the tap may run at)

| Number used | What it is | Source |
|---|---|---|
| Full-open 8 L/min (`QMAX=8.0`) | Just under the US federal maximum for faucets: **2.2 gpm = 8.3 L/min at 60 psi** (Energy Policy Act 1992, as updated; originally 2.5 gpm at 80 psi) | [Building America Solution Center - Bathroom Faucets](https://basc.pnnl.gov/resource-guides/bathroom-faucets) and [EPA WaterSense high-efficiency faucet spec](https://nepis.epa.gov/Exe/ZyPURL.cgi?Dockey=P1008DQX.TXT) |
| Default 50% limit = 5.7 L/min | Matches **EPA WaterSense** for lavatory faucets: **1.5 gpm = 5.7 L/min** (8.0 x sqrt(0.5) = 5.66) | [EPA WaterSense spec](https://nepis.epa.gov/Exe/ZyPURL.cgi?Dockey=P1008DQX.TXT) |
| "A running tap wastes over 6 L/min" | UK water industry figure used for the waste comparisons | [Water UK](https://www.water.org.uk/news-views-publications/news/quick-fix-way-cut-water-waste-home) |

Consequence, computed from the above: a tap left running an hour at ~8 L/min
wastes about **480 L** (the simulator's headline comparison). TapTamer's worst
case is one self-closing 3-minute wash at the set limit - 17 L at the WaterSense
rate, 24 L only if you set the limit to full.

## Waste and cost figures

| Number used | What it is | Source |
|---|---|---|
| **5,500 L/year** lost by a single dripping tap | Water UK / UK energy-agency figure, widely quoted | [Water UK](https://www.water.org.uk/news-views-publications/news/quick-fix-way-cut-water-waste-home), [Energy Agency UK](https://www.energyagency.org.uk/saving-water) |
| **KSh 45-48 per 1,000 L** (cost math on the panel) | Nairobi City Water & Sewerage domestic block tariff: KSh 45 per m³ for the 1-6 m³ block (2023 review); WASREB block structure continues in current tariffs | [Kenyans.co.ke - Nairobi Water announces new prices](https://www.kenyans.co.ke/news/85089-nairobi-water-announces-new-prices-penalties) |
| "480 L ≈ KSh 22", "a wash ≈ KSh 1" | Straight multiplication of the two figures above - arithmetic, not a new source | - |

Because TapTamer cannot leave a flow open, the 480 L "left running" case
becomes impossible by construction; the residual worst case is the single
self-closing wash.

## Thread and hole sizes (why it actually fits your basin)

| Number used | What it is | Source |
|---|---|---|
| **G1/2 = 20.955 mm major dia, 14 TPI, 1.814 mm pitch, 18.632 mm minor** | The 1/2" BSP parallel thread - the standard tap tail worldwide. The printed tail bed and the brass insert, back-nut and hose all use this | [Machining Doctor BSPP thread table](https://www.machiningdoctor.com/threadinfo-bspp-new/?tid=4704), [Turn2 Engineering BSP chart](https://turn2engineering.com/charts-and-tables/bsp-thread-chart) |
| **35 mm basin hole** | The normal kitchen tap hole diameter; basin holes are the same family | [Trade discussion with measurements](https://www.mybuilder.com/questions/v/76697/can-35mm-cartridge-kitchen-tap-replace-a-40mm-cartridge-kitchen-tap) |
| Tap tail hose **1/2" BSP x M10**, 300-500 mm | The standard flexible connector fitting sold everywhere | [Example listing - 1/2" x M10 flexi](https://pepte.eu/products/1-2-inch-x-m10-50cm-flexi-flexible-kitchen-basin-monobloc-tap-connector-hose-pipe) |
| **19 x 12 mm** washer = "1/2 inch" | Standard 1/2" tap/hose washer size, used on the poppet face | [uxcell 19x12x3 washer listing](https://www.amazon.com/uxcell-Rubber-Washers-Thickness-Stainless/dp/B08PTXJLSB), [DANCO 1/2 in. washers](https://www.homedepot.com/p/DANCO-1-2-in-Rubber-Washers-2-Pack-10401/100153745) |

## The cartridge-in-the-head precedent

| Number used | What it is | Source |
|---|---|---|
| **25 / 30 / 35 / 40 mm ceramic cartridges** | Real mixer taps already put the whole valve mechanism in one drop-in cartridge inside the tap head - TapTamer's head cartridge follows the same architecture, just mechanically actuated | [Example cartridge listing, 25/30/35/40 mm](https://www.amazon.com/Ceramic-Cartridge-Replacement-Cartridges-Bathroom/dp/B0H7XHGKSG) |
| **"Back-nut + top-hat washer" fixing** | How ordinary pillar taps clamp through a basin - TapTamer's fitting steps are identical | [Fitting taps with top-hat washers and brass back nuts](https://www.google.com/search?q=top+hat+washer+brass+back+nut+tap+fitting) |

## The dashpot oil

| Number used | What it is | Source |
|---|---|---|
| **350 cSt silicone oil** in both dashpots | RC damper oil is sold in cSt grades 100-1000; Tamiya's # numbers are the cSt values; 350 is a common mid weight | [Euro RC shock-oil guide](https://www.eurorc.com/page/107/rc-shock-oil-guide), [cSt/weight conversion chart](https://www.sodialed.com/rc-setup-tips/rc-shock-oil-viscosity-comparison-chart) |
| Orifice ~1.8 mm -> ~8 s, ~1.1 mm -> ~3 min | **Design target, not a published fact.** Orifice flow is tuned on the bench: wider = faster, narrower = slower. The needle supplied with the oil is the trimming tool | Bench procedure in [02 - Build Guide](02-BUILD-GUIDE.md) |

## Materials

| Claim | Basis |
|---|---|
| PETG for all wet parts | PETG is the standard hobbyist choice for water contact and handles typical domestic hot-tap water (taps run ~50-60 C). PETG softens approaching ~80 C - if your hot water runs hotter than that at the tap, print the wet body in ASA/ABS instead. **This is the one place where the guidance is general practice rather than a cited standard.** |
| NSF potable epoxy putty | J-B Weld WaterWeld is NSF-certified for drinking-water contact; PC-Plumbing putty is NSF-rated for potable water; Superfast Aqua PW is rated for potable fittings. Sources: [J-B Weld WaterWeld](https://www.homedepot.com/p/J-B-Weld-2-oz-Waterweld-Epoxy-8277/202528473), [Superfast Aqua PW](https://sylmasta.com/product/superfast-aqua-potable-water-epoxy-putty-stick/) |

## Honest limitations

1. The 8 s and 3 min close times depend on oil temperature and orifice trim -
   the published research anchor is the cSt grading; the *times* are targets
   you tune in two minutes with the needle.
2. Tariffs change: re-check your water bill's per-m³ rate before quoting
   savings; the structure above is Nairobi's 2023-published block tariff.
3. Print strength: a printed tap body is for normal household basins. Do not
   install it where it will be stood on, wrenched, or used with industrial
   pressure above what a domestic supply provides.
4. The simulator's water accounting uses a sqrt-throttle curve typical of
   orifice flow - it is a good model, not a laboratory calibration.
