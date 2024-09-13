# Project Title:
Music Synthesizer with Chord Player, Harmonics, Dynamics, and PMOD Integration

## Team Members:
- Vincent Thai
- William Pan
- Yale Wang

## Overview:
For this project, we designed and implemented a digital music synthesizer capable of playing chords, harmonic tones, and dynamic audio effects. We also integrated a PMOD numpad for real-time note control. The system was implemented using Verilog and simulated on an FPGA.

## Features:
### 1. Chord Player & Harmonics Implementation:
- **Chord Player**: Capable of playing up to 4 notes simultaneously, selected from a defined range (1A to 6B).
- **Harmonics**: Plays the first, second, and third harmonic overtones alongside the fundamental frequency.
- **Song ROM**: Supports multiple songs, including one based on "Si Veo A Tu Mama" by Bad Bunny.
- **Key Modules**:
  - `note_player`: Adapted to play frequency instead of note for precise harmonics.
  - `harmonics_player`: Outputs sine waves for the fundamental and overtones.

### 2. Dynamics Implementation:
- Full ADSR (Attack, Decay, Sustain, Release) envelope to control the amplitude of notes.
- Generalized enough to support various envelope phases for different instrument sounds.
- **Button 3** on the FPGA toggles dynamics on or off.

### 3. PMOD-Numpad Implementation:
- Allows real-time note input from a PMOD numpad.
- Each key (1-8) plays a corresponding note (4C-5C).
- The numpad input is visualized on the FPGA’s LEDs.

### 4. Division Approximation (Extra Feature):
- Division approximation using a custom ROM and right bit-shifting to efficiently handle scaling factors without native division operations in Verilog.

## Block Diagrams:
![Figure 1](figure1.png)

![Figure 2](figure2.png)

![Figure 3](figure3.png)

![Figure 4](figure4.png)


## Testing:
- Comprehensive testbenches were created for key modules (`notes_player`, `divide`, `key_board`) to ensure correct functionality.
- Waveform visualizations were used to verify sound wave correctness and timing.

## Challenges:
- Initial timing issues with song and note loading were resolved after detailed waveform analysis.
- Division and scaling approximations were implemented to handle non-power-of-two operations.
- Key debouncing on the PMOD numpad required significant debugging but was resolved by addressing a timing violation elsewhere in the code.

## Future Work:
- Support for more complex songs and dynamic effects.
- Integration of different envelope shapes for a wider range of instrument emulation.
- Improved user interface for real-time control of note dynamics and harmonics.

## How to Run:
1. **Hardware Requirements**: 
   - FPGA development board with support for PMODs.
   - PMOD numpad.
2. **Software**: 
   - Xilinx Vivado for Verilog simulation and bitstream generation.
3. **Setup**: 
   - Load the provided Verilog code into Vivado.
   - Simulate using the provided testbenches.
   - Deploy to your FPGA board and connect the PMOD numpad.
4. **Controls**: 
   - Use the numpad to play notes in real-time.
   - Toggle dynamics on/off with Button 3.
