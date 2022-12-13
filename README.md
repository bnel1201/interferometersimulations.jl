---
title: InterferometerSimulations a small framework for simulating x-ray grating interferometry in Julia
author: Brandon J. Nelson
---


## Getting Started

1. With [Julia](https://julialang.org/) installed, activate the Julia command line, by typing `julia` in the terminal
2. Enter the Julia package manage by entering `]` 
3. Instantiate the environment with `activate .`, "pkg>" should appear as below to show you are in the package manager:
4. run a sample script (be sure to include `--project=.` to use the current environment while running the script)

```bash
julia --project=.  scripts/make_psc.jl
```

5. try the next script with noise and inhomogenous phase gradients

```bash
julia --project=.  scripts/make_more_realistic_psc.jl
```

## Summary

X-rays are an energetic form of light with wavelengths 10,000 times shorter than visible light. A useful property of x-rays is that biological tissues being mostly made of water and low atomic number materials are partially transparent to x-rays. This *partial* transparency is important because the x-rays that pass through biological tissue contain information about the content and structure of the material they passed through which is why the most common use of x-rays is for medical imaging. X-ray radiographs are shadow cast images of the imaged anatomy and have a broad range of diagnostic and interventional applications from mammography, chest imaging to detect pneumonia, musculoskeletal imaging to detect bone fractures etc... 

The primary physical interaction of x-rays that has been used to generate images since their discovery by Wilhelm Roentgen in 1901 has been that of x-ray absorption. An x-ray radriograph is thus a 2D map of the x-rays removed from the incident beam by photoelectric absorption or Compton scatter from the
