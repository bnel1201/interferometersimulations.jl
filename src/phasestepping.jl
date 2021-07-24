module PhaseStepping

export phase_step

using ..Phantoms: PhaseContrastData

"""
sample_moire_pattern(proj::PhaseContrastData, step_position=0; ref=false, moire_periods=5, ϕ=0)

step_position: x_n = 2\pi n/N step position as fraction of 1 period
ref: if true returns a reference moire pattern with no object
ϕ: the system phase  (can be a scalar or 2D array)
"""
function sample_moire_pattern(proj::PhaseContrastData, step_position=0; ref=false, moire_periods=5, ϕ=0)
    M, N = size(proj)
    lateral_position = [2*π*moire_periods*i/M for i = range(1, M, step=1), j = range(1, N, step=1)];
    if ref
        proj = PhaseContrastData(0, 0, 1)
    end
    return 1 .- proj.atten .+ proj.vis.*cos.(step_position .+ proj.phase .+ lateral_position .+ ϕ)
end

function phase_step(proj::PhaseContrastData; ref=false, nsteps=3, nperiods=1)
    stepsize = nperiods/nsteps
    steps = 2π*(0:stepsize:nperiods-stepsize)
    return cat([sample_moire_pattern(proj, step; ref=ref) for step in steps]..., dims=3)
end

"""
phase_step(proj::PhaseContrastData, steps::AbstractVector; ref=false)

when specifying custom steps, steps are in units of radians
"""
function phase_step(proj::PhaseContrastData, steps::AbstractVector; ref=false)
    return cat([sample_moire_pattern(proj, step; ref=ref) for step in steps]..., dims=3)
end

end