##
using Test: @test
using Statistics
using FFTW
using InterferometerSimulations

##
true_proj = phantom_dataset()
nperiods = 10
nsteps = 40
ref = phase_step(true_proj, ref=true, nsteps=nsteps, nperiods=nperiods)
obj = phase_step(true_proj, nsteps=nsteps, nperiods=nperiods)

@test (size(ref), size(obj)) == ((100, 100, nsteps), (100, 100, nsteps))

@test minimum(ref) ≈ 0
@test mean(ref) ≈ 1
@test maximum(ref) ≈ 2

@test mean(obj) < mean(ref)

## test periods

point = ref[1,1,:]
ref_freq_response = abs.(fft(point)[2:Int(length(point)//2)])
max_freq = argmax(ref_freq_response)
@test max_freq == nperiods