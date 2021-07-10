##
using Test: @test
using Statistics
using InterferometerSimulations
using GratingInterferometry
using DSP

##
true_proj = phantom_dataset()
nperiods = 1
ref = phase_step(true_proj, ref=true, nsteps=10, nperiods=nperiods)
obj = phase_step(true_proj, nsteps=10, nperiods=nperiods)

@test (size(ref), size(obj)) == ((100, 100, 10), (100, 100, 10))

@test minimum(ref) ≈ 0
@test mean(ref) ≈ 1
@test maximum(ref) ≈ 2

@test mean(obj) < mean(ref)
##
steps = StepData(obj, ref, nperiods)
retrieved_proj = retrieve(steps)
## test atten
@test isapprox(mean(retrieved_proj.Ab), mean(true_proj.atten), rtol=2e-2)
## test phase
phase = unwrap(retrieved_proj.Δϕ[:,:,1], dims=1)
@test mean(phase) ≈ mean(true_proj.phase)

## test vis
@test 2-mean(exp.(-retrieved_proj.VN)) ≈ mean(true_proj.vis) #need to get to the bottom of why I need to subtract from 2...