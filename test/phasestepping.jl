##
using Test: @test
using Statistics
using InterferometerSimulations

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
