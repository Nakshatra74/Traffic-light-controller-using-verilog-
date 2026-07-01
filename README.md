# Traffic Light Controller FSM (Xilinx Vivado)

This repository contains a Verilog implementation of a Finite State Machine (FSM) designed to control a traffic light intersection. This project was developed and simulated using **Xilinx Vivado**. It includes standard light cycling, a pedestrian crossing button, and an emergency vehicle override mechanism.

## Features

* **Standard Light Cycle:** Cycles through Red (10 clock cycles) -> Green (8 clock cycles) -> Yellow (2 clock cycles).
* **Pedestrian Button (`ped_btn`):** Allows pedestrians to request a crossing. If the light is Green and the minimum green time (5 cycles) has passed, it will trigger an early transition to Yellow, then Red.
* **Emergency Override (`emergency`):** Immediately switches the traffic light to Green (and `dont_walk`) to allow emergency vehicles to pass, holding this state until the signal is released.
* **Parameterized Timings:** Easily modify state durations (`red_time`, `green_time`, `yellow_time`, `min_green_time`) using Verilog parameters.

## Module Interface

### Inputs
| Signal | Width | Description |
| :--- | :---: | :--- |
| `clk` | 1 | System clock. |
| `reset` | 1 | Synchronous active-high reset. Forces the FSM to `s_red`. |
| `ped_btn` | 1 | Pedestrian crossing button. |
| `emergency` | 1 | Emergency vehicle override signal. |

### Outputs
| Signal | Width | Description |
| :--- | :---: | :--- |
| `red` | 1 | Red traffic light signal. |
| `yellow` | 1 | Yellow traffic light signal. |
| `green` | 1 | Green traffic light signal. |
| `walk` | 1 | Pedestrian walk signal (active during Red). |
| `dont_walk` | 1 | Pedestrian don't walk signal. |

## Finite State Machine (FSM) Overview

The FSM consists of three main states:
1. `s_red` (2'b00): Red light is ON. `walk` is ON. Transitions to `s_green` after `red_time`.
2. `s_green` (2'b01): Green light is ON. `dont_walk` is ON. Transitions to `s_yellow` after `green_time`, OR if `ped_btn` is pressed and `min_green_time` has elapsed.
3. `s_yellow` (2'b10): Yellow light is ON. `dont_walk` is ON. Transitions to `s_red` after `yellow_time`.

*Note: The `emergency` input acts as a combinational override on the outputs, immediately forcing the lights to Green/Dont Walk regardless of the current state, without resetting the FSM state memory.*

## Simulation and Testing in Vivado

A testbench is provided to verify the functionality of the FSM across different edge cases. 

### Test Scenarios Covered:
1. **Normal Operation:** Verifies the standard Red -> Green -> Yellow cycle based on the parameterized timers.
2. **Pedestrian Override:** Asserts the pedestrian button during the Green state to verify early transition logic.
3. **Emergency Override:** Asserts the emergency signal during a Red state to ensure immediate Green light output.
