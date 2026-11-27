# 45 nm CMOS Adders and Ring Oscillators

Transistor-level HSPICE simulations of CMOS arithmetic and ring oscillators using FreePDK45. The adder testbenches compare two full-adder implementations under the same input sequence. The oscillator testbenches compare how many inverter, NAND, or NOR stages are needed to reach a 1 ns period.

## Run a simulation

Use Synopsys PrimeSim HSPICE and the [NC State FreePDK45 base kit](https://eda.ncsu.edu/freepdk/freepdk45/). Set `PDK_DIR` to the directory containing `ncsu_basekit`. The testbenches load the nominal models from `ncsu_basekit/models/hspice/hspice_nom.include`.

From the repository root, run the following in Bash. In tcsh, use `setenv PDK_DIR /path/to/FreePDK45` in place of the first command.

```sh
export PDK_DIR=/path/to/FreePDK45
cd netlists
mkdir -p ../runs
hspice -i full_adder_nand.sp -o ../runs/full_adder_nand
```

Use any `.sp` file below as the input deck. HSPICE writes the listing (`.lis`), measurement summary (`.mt0`), and transient waveform (`.tr0`) under the output prefix. Open the `.tr0` file in a viewer such as Synopsys Custom WaveView. The [waveforms](waveforms/) directory contains example captures.

## Adder results

The full-adder inputs step through all eight combinations of `A0`, `B0`, and `Cin0` over 8 ns. The four-bit ripple-carry adder chains four full adders with the initial carry tied low. Its test vector is `1011 + 1010`, which settles to `10101` on `C4:S4:S3:S2:S1`.

| Testbench | MOSFETs | Average supply power | Peak supply power | Waveform |
| --- | ---: | ---: | ---: | --- |
| [Half adder](netlists/half_adder.sp) | 18 | 0.7045 µW | 0.3281 mW | [Capture](waveforms/half_adder.png) |
| [Full adder using two half adders](netlists/full_adder_two_half_adders.sp) | 42 | 8.199 µW | 0.7432 mW | [Capture](waveforms/full_adder_two_half_adders.png) |
| [Nine-NAND full adder](netlists/full_adder_nand.sp) | 36 | 7.162 µW | 0.5581 mW | [Capture](waveforms/full_adder_nand.png) |
| [Four-bit ripple-carry adder](netlists/ripple_carry_adder_4bit.sp) | 168 | 4.178 µW | 1.105 mW | [Capture](waveforms/ripple_carry_adder_4bit.png) |

Under the shared full-adder stimulus, the nine-NAND implementation used six fewer transistors and drew 12.6% less average power and 24.9% less peak power. The half-adder and four-bit decks use different stimuli. Their power values describe those specific runs.

## Ring oscillator results

Each ring has an odd number of inverting stages. The NAND and NOR variants tie one input per gate high or low, respectively, to make each gate invert. The period is measured between the second and third rising crossings of half the supply voltage.

| Testbench | Stages | Measured period |
| --- | ---: | ---: |
| [Seven-stage inverter ring](netlists/ring_inverter_7stage.sp) | 7 | 79.65 ps |
| [1 ns inverter ring](netlists/ring_inverter_1ns.sp) | 87 | 989.8 ps |
| [1 ns NAND ring](netlists/ring_nand_1ns.sp) | 55 | 998.0 ps |
| [1 ns NOR ring](netlists/ring_nor_1ns.sp) | 39 | 992.5 ps |

The NAND ring came closest to 1 ns, within 0.2% of the target. The [seven-stage waveform](waveforms/ring_inverter_7stage.png) shows the phase progression around the loop.

All results come from saved PrimeSim HSPICE transient runs at 1.0 V and 25 °C.

## Acknowledgments

The half-adder implementation uses a supplied reference topology. [cmos_cells.inc](netlists/cmos_cells.inc) retains the inverter, NAND, and NOR definitions from the supplied `Subcircuits.sp`.

