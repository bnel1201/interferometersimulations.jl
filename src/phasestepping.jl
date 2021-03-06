module PhaseStepping

export phase_step

using ..Phantoms: PhaseContrastData

"""
sample_moire_pattern(proj::PhaseContrastData, stepposition=0; ref=false, moireperiods=5, ϕ=0)


stepposition: x_n = 2 pi n/N step position as fraction of 1 period
ref: if true returns a reference moire pattern with no object
ϕ: the system phase  (can be a scalar or 2D array)
I0: baseline intensity measurement, by default I0 = 2^16*0.9 = 58982.4,
this accounts for a 16 bit dectector bin filled to 90%
"""
function sample_moire_pattern(proj::PhaseContrastData, stepposition=0; ref=false, moireperiods=5, ϕ=0, I0=58982.4, ref_vis=0.3)
    M, N = size(proj)
    lateral_position = [2*π*moireperiods*i/M for i = range(1, M, step=1), j = range(1, N, step=1)]';
    if ref
        proj = PhaseContrastData(0, 0, 1) #define ref visibility as 30%
    end
    return I0*((1-ref_vis/2) .- proj.atten .+ (proj.vis*ref_vis/2).*cos.(stepposition .+ proj.phase .+ lateral_position .+ ϕ))
end

function phase_step(proj::PhaseContrastData; nsteps=3, nperiods=1, kwargs...)
    stepsize = nperiods/nsteps
    steps = 2π*(0:stepsize:nperiods-stepsize)
    return cat([sample_moire_pattern(proj, step; kwargs...) for step in steps]..., dims=3)
end

"""
phase_step(proj::PhaseContrastData, steps::AbstractVector; ref=false)

when specifying custom steps, steps are in units of radians
"""
function phase_step(proj::PhaseContrastData, steps::AbstractVector; kwargs...)
    return cat([sample_moire_pattern(proj, step; kwargs...) for step in steps]..., dims=3)
end

end