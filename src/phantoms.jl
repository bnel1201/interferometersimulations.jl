module Phantoms

export ellipsoid, PhaseContrastData, phantom_dataset

"""
# Phantoms.ellipsoid(;foci=(0.5, 0.5, 0.5), axes=(0.25, 0.25, 0.25), N=100)

## Summary
Generates a 3D volume of size NxNxN with an ellipsoid centered at `foci` with major axes defined by `axes`

## Arguments
foci: tuple (x, y, z) relative location of ellipsoid center between [0, 1]
axes: major axes relative dimensions between [0, 1]
N: side length of dimensions of volume N^3
"""
function ellipsoid(;foci=(0.5, 0.5, 0.5), axes=(0.25, 0.25, 0.25), N=100)
    foci = Int.(round.(foci.*N))
    axes = Int.(round.(axes.*N))
    @assert all([c - r > 0 for (c, r) in zip(foci, axes)])
    @assert all([c + r < N for (c, r) in zip(foci, axes)])
    A = zeros((N, N, N))
    for i in range(1, N, step=1)
        for j in range(1, N, step=1)
            for k in range(1, N, step=1)
                if sqrt(((i-foci[1])/axes[1])^2 + ((j-foci[2])/axes[2])^2 + ((k-foci[3])/axes[3])^2) < 1
                    A[i, j, k] = 1
                end
            end
        end
    end
    return A
end

struct PhaseContrastData
    atten
    phase
    vis
end

import Base.size
function Base.size(proj::PhaseContrastData)
   return size(proj.atten) 
end

project(A,dims=1) = sum(A, dims=dims)[1,:,:]

"""
# phantom_dataset(phantom=ellipsoid(); true_atten_val = 1e-3, true_phase_val = π/200, true_vis_val = 0.5e-3)

## Summary
Take a 2D or 3D array and turn it into a PhaseContrastData set while assigning values for atten, phase, and visibility
"""
function phantom_dataset(phantom=ellipsoid(); true_atten_val = 1e-3, true_phase_val = π/200, true_vis_val = 0.5e-3)
    true_atten = project(true_atten_val.*phantom)
    true_phase = project(true_phase_val.*phantom)
    true_vis = 1 .- project(true_vis_val.*phantom)
    return PhaseContrastData(true_atten, true_phase, true_vis)
end

end