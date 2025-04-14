#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 14 15:08:50 2025

@author: fatimarahimi
"""

# 🧬 Chemotherapy Simulation

This Java-based project models the effects of chemotherapy on tumor cell populations using **genetic algorithms** 
and **flocking behavior**. It simulates how cells evolve over time under treatment pressure, helping visualize mutation, resistance, 
and recovery dynamics.

## 🎯 Features

- Genetic algorithms simulate evolving cell populations
  - Traits: drug resistance, mutation rate, replication speed
- Flocking behavior (inspired by boid simulations) models local cell interactions
  - Rules: alignment, cohesion, separation
- Visualization of tumor dynamics under varying chemotherapy intensity
- Adjustable parameters for mutation probability, drug effectiveness, and cell density

## 🧪 How It Works

- Each "cell" is represented as an object with genetic traits
- The population evolves through selection, mutation, and inheritance
- Chemotherapy is modeled as a pressure that reduces cell survival based on resistance
- Flocking behavior creates natural-looking clustering and movement patterns


### Requirements

- Java 8+
- [Processing](https://processing.org/download) (if built with Processing)
